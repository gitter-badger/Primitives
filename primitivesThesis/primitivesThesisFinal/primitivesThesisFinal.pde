//Primitives by Claire Mitchell - recognition portion adapted from Makematics course at ITP using HandGestureRecognizerInteractive by Greg Borenstein

/*
HandGestureRecognizerInteractive by Greg Borenstein, October 2012
 Distributed as part of PSVM: http://makematics.com/code/psvm
 
 Depends on HoG Processing: http://hogprocessing.altervista.org/
 
 Uses a trained Support Vector Machine to detect hand gestures in live video.
 SVM is trained based on Histogram of Oriented Gradients on the 
 Sebastien Marcel Hand Pose Dataset: http://www.idiap.ch/resource/gestures/
 */



import hog.*;
import psvm.*;
import processing.serial.*;
import processing.video.*;

Capture video;
Serial port;

//NEW SHAPES SAVED TO TRAINING FILE
boolean newTriangle, newCircle, newRectangle, newScribble, newStar, newNothing, newPerson;
int tcount = 0;
int rcount = 0;
int ccount = 0;
int ncount = 0;
int scount = 0;
int acount = 0;
int pcount=0;
PImage newShapeImage;

//SHAPE DETECTED
boolean received = false;
boolean receivedTriangle =false;
boolean receivedRect = false;
boolean receivedEllipse = false;
boolean receivedStar = false;
boolean receivedScribble = false;
boolean receivedNothing = false;
boolean receivedPerson = false;

//DISPLAY RECOGNITION AREA
boolean displayRect = true;
int rectW = 250;
int rectH = 250;

boolean detect = false;
//MOTION DETECTED
boolean thereIsMotion = false;
PImage prevFrame;
float threshold = 50;
boolean ready = false;

//SVM MODEL CREATION
SVM model;
int[] labels; //5 = star; 6 = rect; 7 = triangle; 8 = circle;
String[] trainingFilenames, testFilenames;
float[][] trainingFeatures;
PImage testImage;
double testResult = 0.0;
PImage img;

void setup() {
  size(640/2, 480/2);
  video = new Capture(this, "name=Logitech Camera, size=480x270,fps=30"); 
  video.start();

  //DECLARE THE TRAINING MODEL
  model = new SVM(this);
  //model.loadModel("shapeRecognition_model_dynamic.txt", 324);
  model.loadModel("shapeRecognition_model041513_dynamic.txt", 324);

  //CREATE TEST IMAGE
  testImage = createImage(50, 50, RGB);
  //CREATE NEW TRAINING IMAGE
  newShapeImage = createImage(50, 50, RGB);
  //INDICATE PATH TO TRAINING IMAGES
  java.io.File folder = new java.io.File(dataPath("train"));
  trainingFilenames = folder.list();
  labels = new int[trainingFilenames.length];
  trainingFeatures = new float[trainingFilenames.length][324];

  //OPEN SERIAL PORT
  port = new Serial(this, Serial.list() [0], 9600);

  //MOTION DETECTION
  //prevFrame = createImage(video.width, video.height, RGB);
}

void draw() {
  //LOAD UPDATED TRAINING MODEL

  //SET NEW TRAINING OBJECTS TO FALSE
  newTriangle = false;
  newCircle = false;
  newRectangle = false;
  newStar = false;
  newScribble = false;
  newPerson = false;

  //DISPLAY INCOMING VIDEO
  image(video, 0, 0);

  //CREATE VARIABLE FOR SERVO ANGLE (CAMERA ANGLE)
  int angle = int(map(mouseX, 0, width, 90, 120));
  // port.write(angle);

  //PERFORM OBJECT RECOGNITION
  //determine area of video to test
  testImage.copy(video, video.width - rectW - (video.width - rectW)/2 - 50, video.height - rectH - (video.height - rectH)/2, rectW, rectH, 0, 0, 50, 50);

  if (detect == true) {
    performDetection();
  }
}




//HOG GRADIENT CALCULATIONS  - FEATURE VECTORS FOR SVM
//DESCRIBES SHAPE OF OBJECTS AS BRIGHT AND DARK PIXELS 
float[] gradientsForImage(PImage img) {
  img.resize(50, 50);  
  int window_width= 64;
  int window_height= 128;
  int bins = 9; 
  int cell_size = 8;
  int block_size = 2;
  boolean signed = false;
  int overlap = 0;
  int stride = 16;
  int number_of_resizes = 5;

  HOG_Factory hog = HOG.createInstance();
  GradientsComputation gc = hog.createGradientsComputation();
  Voter voter = MagnitudeItselfVoter.createMagnitudeItselfVoter();
  HistogramsComputation hc = hog.createHistogramsComputation(bins, cell_size, cell_size, signed, voter);
  Norm norm = L2_Norm.createL2_Norm(.1);
  BlocksComputation bc = hog.createBlocksComputation(block_size, block_size, overlap, norm);
  PixelGradientVector[][] pixelGradients = gc.computeGradients(img, this);
  Histogram[][] histograms = hc.computeHistograms(pixelGradients);
  Block[][] blocks = bc.computeBlocks(histograms);
  Block[][] normalizedBlocks = bc.normalizeBlocks(blocks);
  DescriptorComputation dc = hog.createDescriptorComputation();

  return dc.computeDescriptor(normalizedBlocks);
}


void createNewTrainingModel() {
  //USE TRAINING IMAGES TO CREATE NEW TRAINING MODEL FILE
  for (int i = 0; i < trainingFilenames.length; i++) {
    //  println(trainingFilenames[i]);
    if (trainingFilenames[i].equals(".DS_Store")) {
      println("skipping .DS_Store file");
      continue;
    } 

    //DETERMIN LABEL Of TRAINING IMAGE
    String gestureLabel = split(trainingFilenames[i], '-')[0];


    if (gestureLabel.equals("nada")) {
      labels[i] = 1;
    }  
    if (gestureLabel.equals("scribble")) {
      labels[i] = 3;
    }
    if (gestureLabel.equals("person")) {
      labels[i] = 4;
    }
    if (gestureLabel.equals("star")) {
      labels[i] = 5;
    }
    if (gestureLabel.equals("rect")) {
      labels[i] = 6;
    }
    if (gestureLabel.equals("triangle")) {
      labels[i] = 7;
    }
    if (gestureLabel.equals("circle")) {
      labels[i] = 8;
    }

    trainingFeatures[i] = gradientsForImage(loadImage("train/" + trainingFilenames[i]));
  }

  model = new SVM(this);
  SVMProblem problem = new SVMProblem();

  problem.setNumFeatures(324);
  problem.setSampleData(labels, trainingFeatures);
  model.train(problem);

  model.saveModel("shapeRecognition_model041513_dynamic.txt");

  java.io.File testFolder = new java.io.File(dataPath("test"));
  testFilenames = testFolder.list();

  testResult = testNewImage();
}


double testNewImage() {
  int imgNum = (int)random(0, testFilenames.length- 1);
  testImage = loadImage("test/"+ testFilenames[imgNum]);
  return model.test(gradientsForImage(testImage));
}


void keyPressed() {
  if (key == 't') {
    newTriangle=true;
    testImage.save("data/train/triangle-uniform1" + tcount + ".jpg");
    tcount++;
    createNewTrainingModel(); 
    model.loadModel("shapeRecognition_model041513_dynamic.txt", 324);
    newTriangle=false;
    println("Saving as training image of TRIANGLE");
  } 


  if (key == 'c') {
    newCircle = true;
    testImage.save("data/train/circle-uniform1" + ccount + ".jpg");
    ccount++;
    createNewTrainingModel(); 
    model.loadModel("shapeRecognition_model041513_dynamic.txt", 324);
    newCircle=false;
    println("Saving as training image of CIRCLE");
  } 

  if (key == 'r') {
    newRectangle = true;
    testImage.save("data/train/rect-uniform1" + rcount + ".jpg");
    rcount++;
    createNewTrainingModel(); 
    model.loadModel("shapeRecognition_model041513_dynamic.txt", 324);
    newRectangle=false;
    println("Saving as training image of RECTANGLE");
  }

  if (key == 'n') {
    newNothing = true;
    testImage.save("data/train/nada-uniform1" + ncount + ".jpg");
    ncount++;
    createNewTrainingModel(); 
    model.loadModel("shapeRecognition_model041513_dynamic.txt", 324);
    newNothing=false;
    println("Saving as training image of NOTHING THERE");
  }

  if (key == 's') {
    newScribble = true;
    testImage.save("data/train/scribble-uniform1" + scount + ".jpg");
    scount++;
    createNewTrainingModel(); 
    model.loadModel("shapeRecognition_model041513_dynamic.txt", 324);
    newScribble=false;
    println("Saving as training image of SCRIBBLE");
  }

  if (key == 'a') {
    newStar = true;
    testImage.save("data/train/star-uniform1" + acount + ".jpg");
    acount++;
    createNewTrainingModel(); 
    model.loadModel("shapeRecognition_model041513_dynamic.txt", 324);
    newStar=false;
    println("Saving as training image of STAR");
  }

  if (key == 'p') {
    newPerson = true;
    testImage.save("data/train/person-uniform2" + pcount + ".jpg");
    pcount++;
    createNewTrainingModel(); 
    model.loadModel("shapeRecognition_model041513_dynamic.txt", 324);
    newPerson=false;
    println("Saving as training image of SMILEY FACE");
  }
}

void captureEvent(Capture c) {
  // c.read();
  prevFrame = c.get(); // 
  prevFrame.updatePixels();
  c.read();
  ready = true;
}




void rememberTriangle() {
  newTriangle=true;
  testImage.save("data/train/triangle-uniform4" + tcount + ".jpg");
  tcount++;
  createNewTrainingModel(); 
  model.loadModel("shapeRecognition_model041513_dynamic.txt", 324);
  newTriangle=false;
  println("Saving as training image of TRIANGLE");
}

void rememberCircle() {
  newCircle = true;
  testImage.save("data/train/circle-uniform4" + ccount + ".jpg");
  ccount++;
  createNewTrainingModel(); 
  model.loadModel("shapeRecognition_model041513_dynamic.txt", 324);
  newCircle=false;
  println("Saving as training image of CIRCLE");
}

void rememberRectangle() {
  newRectangle = true;
  testImage.save("data/train/rect-uniform4" + rcount + ".jpg");
  rcount++;
  createNewTrainingModel(); 
  model.loadModel("shapeRecognition_model041513_dynamic.txt", 324);
  newRectangle=false;
  println("Saving as training image of RECTANGLE");
}


void performDetection() {

  double testResult = model.test(gradientsForImage(testImage));

  //DISPLAY THE AREA OF TESTING
  if (displayRect == true) {
    image(testImage, width-testImage.width, 0);
    noFill();
    stroke(0, 0, 0);
    strokeWeight(5);
    rectMode(RIGHT);
    rect(video.width - rectW/2-(video.width-rectW)-50, video.height-rectH-(video.height - rectH)+50, rectW+50, rectH-50);

    //DISPLAY RESULTS
    String result = "this is a ";
    switch((int)testResult) {
    case 1:
      fill(255);
      result = result + "nada";
      break;
    case 2:
      fill(255);
      result = result + "placeholder";
      break;
    case 3:
      fill(255);
      result = result + "scribble";
      break;
    case 4:
      fill(255);
      result = result + "person";
      break;
    case 5:
      fill(255);
      result = result + "star";
      break;        
    case 6:
      fill(255);
      result = result + "rect";
      break;   
    case 7:
      fill(255);
      result = result + "triangle";
      break;   
    case 8:
      fill(255);
      result = result + "circle";
      break;
    }
    text(result, 100, 20);
  }


  if (testResult == 1) {
    displayRect = false; 
    port.write(49);
    println("nada");
    receivedNothing = true;
    receivedNothing = false;
  }


  if (testResult == 3) {
    displayRect = false; 
    port.write(51);
    println("scribble");
    receivedScribble = true;
  }


  if (testResult == 4) {
    displayRect = false; 
    port.write(52);
    println("person");
    receivedPerson = true;
  }

  if (testResult == 5) {
    displayRect = false; 
    port.write(53);
    println("star");
    receivedStar = true;
  }


  if (testResult == 6) {
    displayRect = false; 
    port.write(56);
    println("rectangle");
    receivedRect = true;
    //   receivedRect = false;
  }


  if (testResult == 7) {
    displayRect = false; 
    port.write(55);
    println("triangle");
    receivedTriangle = true;
    //   receivedTriangle = false;
  } 

  if (testResult == 8) {
    displayRect = false; 
    port.write(54);
    println("circle");
    receivedEllipse = true;
    //     receivedEllipse = false;
  }
}

void serialEvent(Serial myPort) {
  int inByte = myPort.read();
  if (inByte == 't') {
    rememberTriangle();
  }

  if (inByte == 'r') {
    rememberRectangle();
  }

  if (inByte == 'c') {
    rememberCircle();
  }

  if (inByte == 'x') {
    detect = true;
  }
  else {
    detect = false;
  }
}

