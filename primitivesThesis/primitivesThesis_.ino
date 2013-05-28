
#include <AccelStepper.h>
#include <Servo.h>  

//stepper pins
#define DIR1_PIN (8)
#define STEP1_PIN (9)
#define DIR2_PIN (6)
#define STEP2_PIN (7)
#define DELAY (1600)
AccelStepper stepper1(1, 9, 8);
AccelStepper stepper2(1, 7, 6);

//servo pins
Servo chalkServo;
Servo cameraServo;
int servoPin = 5;
int chalkServoPin = 13;
int val = 0;
int pos = 0; 

//LED pins for user interface
const int circleLED = 3;
const int triangleLED = 2;
const int rectLED = 4;

//pressure sensor for user interface
int pressureSensor = A5;

boolean rectangleButton = true;
int rectButCounter = 0;
boolean circleButton = true;
int circleButCounter = 0;
boolean triangleButton = true;
int triangleButCounter = 0;
boolean pressureButton = true;
int pressureButCounter = 0;


boolean drect = true;
int drectCount = 0;
boolean dcircle = true;
int dcircleCount = 0;
boolean dtri = true;
int dtriCount = 0;
boolean dquest = true;
int dquestCount = 0;


int rectCount = 0;
int circCount = 0;
int triCount = 0;

//define variable to contain shape identification from Processing 
int shape = 0; 

int totalLocationX = 0;

//number of steps to contain canvas
int fullLengthX = 3000;
int fullLengthY = 2500;

int pos1 = fullLengthX/4;
int pos2 = fullLengthY/2;

int sensorValue = 0;



void setup() {
  chalkServo.attach(chalkServoPin); 
  cameraServo.attach(servoPin); 

  pinMode(DIR1_PIN,OUTPUT);
  pinMode(STEP1_PIN,OUTPUT);
  pinMode(DIR2_PIN,OUTPUT);
  pinMode(STEP2_PIN,OUTPUT);


  pinMode(10, INPUT);      // set the switch pin to be an input
  pinMode(11, INPUT);      // CIRCLE BUTTON
  pinMode(12, INPUT);      // RECT BUTTON
  pinMode(2, OUTPUT);   // CIRCLE LED
  pinMode(3, OUTPUT);   // TRIANGLE LED 
  pinMode(4, OUTPUT);   // RECT LED 

  // stepper1.setMaxSpeed(550);
  stepper1.setAcceleration(500);
  //  stepper2.setMaxSpeed(500);
  stepper2.setAcceleration(500);

  Serial.begin(9600);
}

void loop() {
  cameraServo.write(104);    
  if (Serial.available()) {
    shape = Serial.read();
    Serial.println(shape);
  }

  val = 90;

  sensorValue = analogRead(pressureSensor);

  //CIRCLE DETECTED
  if (shape == '6') {   
    digitalWrite(circleLED, HIGH);    // turn on the circle LED
    int i, j = DELAY;
    val = 0;
    chalkServo.write(val); 
    drawCircle2();     
  } 
  else{
    digitalWrite(circleLED, LOW);    // turn off the circle LED
  }

  //TRIANGLE DETECTED
  if (shape == '7') {
    digitalWrite(triangleLED, HIGH);    // turn on the triangle LED
    int location = random(2900,3500);   
    int i,j=DELAY;
    if(dtri == true){
      dtri = false;
      //GO TO NORTHWEST OF BOARD
      digitalWrite(DIR1_PIN, LOW); // Change direction.
      digitalWrite(DIR2_PIN, HIGH); // Change direction.
      delayMicroseconds(DELAY);

      for (i = 0; i<location*2.5; i++) // Iterate though steps.
      {
        digitalWrite(STEP2_PIN, LOW); 
        digitalWrite(STEP2_PIN, HIGH);
        digitalWrite(STEP1_PIN, HIGH);
        digitalWrite(STEP1_PIN, LOW); 
        delayMicroseconds(j-1); 
      }
      val = 0;  
      chalkServo.write(val); 
      drawTriangle(); 
      val=90;
      chalkServo.write(val); 
      //GO TO SOUTHEAST OF BOARD 
      digitalWrite(DIR1_PIN, HIGH); // Change direction.
      digitalWrite(DIR2_PIN, LOW); // Change direction.
      delayMicroseconds(DELAY);

      for (i = 0; i<location*1.5; i++) // Iterate through steps.
      {
        digitalWrite(STEP2_PIN, HIGH);
        digitalWrite(STEP2_PIN, LOW); 
        digitalWrite(STEP1_PIN, HIGH); 
        digitalWrite(STEP1_PIN, LOW);   
        delayMicroseconds(j-1); 
      }
      val = 0;
      chalkServo.write(val); 
      drawTriangle(); 

      val=90;
      chalkServo.write(val); 
      //GO TO SOUTHWEST OF BOARD
      digitalWrite(DIR1_PIN, HIGH); // Change direction.
      digitalWrite(DIR2_PIN, HIGH); // Change direction.
      delayMicroseconds(DELAY);

      for (i = 0; i<location*1.5; i++) // Iterate through steps.
      {
        digitalWrite(STEP2_PIN, LOW); 
        digitalWrite(STEP2_PIN, HIGH);
        digitalWrite(STEP1_PIN, HIGH); 
        digitalWrite(STEP1_PIN, LOW);  
        delayMicroseconds(j-1); 
      }
      val = 0;

      chalkServo.write(val); 
      drawTriangle(); 
      val=90;
      chalkServo.write(val); 
      //GO TO NORTH EAST OF BOARD    
      digitalWrite(DIR1_PIN, LOW); // Change direction.
      digitalWrite(DIR2_PIN, LOW); // Change direction.
      delayMicroseconds(DELAY);

      for (i = 0; i<location*2.5; i++) // Iterate through steps.
      {
        digitalWrite(STEP2_PIN, HIGH); 
        digitalWrite(STEP2_PIN, LOW); 
        digitalWrite(STEP1_PIN, LOW); 
        digitalWrite(STEP1_PIN, HIGH); 
        delayMicroseconds(j-1);
      }
      val = 0;
      chalkServo.write(val); 
      drawTriangle(); 
      val = 90;
      chalkServo.write(val);  

    }
    dtriCount++;
    if (dtriCount > 1){
      dtri =false;
      dtriCount = 0;
    } 
    else {
      dtri =true; 
    }
    totalLocationX = location +totalLocationX;
  }
  else{
    digitalWrite(triangleLED, LOW);    // turn off the triangle LED
  }

  //RECTANGLE DETECTED
  if (shape == '8') {
    digitalWrite(rectLED, HIGH);    // turn on the rect LED
    int location = random(3900,5500);
    int i,j=DELAY;

    if(drect == true){
      drect = false;
      //GO TO NORTH EAST OF BOARD    
      digitalWrite(DIR1_PIN, LOW); // Change direction.
      digitalWrite(DIR2_PIN, LOW); // Change direction.
      delayMicroseconds(DELAY);

      for (i = 0; i<location*2; i++) // Iterate through steps.
      {
        digitalWrite(STEP2_PIN, HIGH); 
        digitalWrite(STEP2_PIN, LOW);
        digitalWrite(STEP1_PIN, LOW); 
        digitalWrite(STEP1_PIN, HIGH); 
        delayMicroseconds(j-1); 
      }
      val = 0;

      chalkServo.write(val); 
      drawRect(); 
      val = 90;
      chalkServo.write(val);  
      //GO TO SOUTHWEST OF BOARD
      digitalWrite(DIR1_PIN, HIGH); // Change direction.
      digitalWrite(DIR2_PIN, HIGH); // Change direction.
      delayMicroseconds(DELAY);

      for (i = 0; i<location*1.5; i++) // Iterate through steps.
      {
        digitalWrite(STEP2_PIN, LOW);
        digitalWrite(STEP2_PIN, HIGH);
        digitalWrite(STEP1_PIN, HIGH); 
        digitalWrite(STEP1_PIN, LOW);  
        delayMicroseconds(j-1); 
      }
      val = 0;

      chalkServo.write(val); 
      drawRect(); 
      val=90;
      chalkServo.write(val); 


      //GO TO SOUTHEAST OF BOARD

      digitalWrite(DIR1_PIN, HIGH); // Change direction.
      digitalWrite(DIR2_PIN, LOW); // Change direction.
      delayMicroseconds(DELAY);

      for (i = 0; i<location*1.5; i++) // Iterate through steps.
      {
        digitalWrite(STEP2_PIN, HIGH); 
        digitalWrite(STEP2_PIN, LOW); 
        digitalWrite(STEP1_PIN, HIGH); 
        digitalWrite(STEP1_PIN, LOW);  
        delayMicroseconds(j-1); 
      }
      val = 0;

      chalkServo.write(val); 
      drawRect(); 
      val=90;
      chalkServo.write(val); 

      //GO TO NORTHWEST OF BOARD
      digitalWrite(DIR1_PIN, LOW); // Change direction.
      digitalWrite(DIR2_PIN, HIGH); // Change direction.
      delayMicroseconds(DELAY);

      for (i = 0; i<location*2.5; i++) // Iterate through steps.
      {
        digitalWrite(STEP2_PIN, LOW);
        digitalWrite(STEP2_PIN, HIGH); 
        digitalWrite(STEP1_PIN, HIGH); 
        digitalWrite(STEP1_PIN, LOW);
        delayMicroseconds(j-1); 
      }
      val = 0;

      chalkServo.write(val); 
      drawRect(); 
      val=90;
      chalkServo.write(val); 

    }
    drectCount++;
    if (drectCount > 1){
      drect =false;
      drectCount = 0;
    } 
    else {
      drect =true; 
    }
    totalLocationX = location +totalLocationX;
  }
  else{
    digitalWrite(rectLED, LOW);    // turn on the rect LED
  }

  chalkServo.write(val); 
  
  
  ///////BUTTONS TO TRAIN MACHINE
  //TRAIN TRIANGLE
  if (digitalRead(10) == HIGH) {

    if( rectangleButton == true){
      rectangleButton = false;
      Serial.print('r');
    }
    rectButCounter++;
    if (rectButCounter > 3300){
      rectangleButton =true;
      rectButCounter = 0;
    }
  } 
  else{
    //Serial.print('z');
  }

  //TRAIN CIRCLE
  if (digitalRead(11) == HIGH) {  
    if( triangleButton == true){
      triangleButton = false;
      Serial.print('t');
    }
    triangleButCounter++;
    if (triangleButCounter > 3300){
      triangleButton =true;
      triangleButCounter = 0;
    }
  } 
  else{
    //Serial.print('z');
  }

  //TRAIN RECTANGLE
  if (digitalRead(12) == HIGH) {
    if( circleButton == true){
      circleButton = false;
      Serial.print('c');
    }
    circleButCounter++;
    if (circleButCounter > 3300){
      circleButton =true;
      circleButCounter = 0;
    }
  } 
  else{
    //Serial.print('z');
  }


  if (sensorValue > 100) {
    if( pressureButton == true){
      pressureButton = false;
      Serial.print('x');
    }
    pressureButCounter++;
    if (pressureButCounter > 2000){
      pressureButton =true;
      pressureButCounter = 0;
    }
  } 
  else{
    //Serial.print('z');
  }
}








void drawRect(){
  int i,j=DELAY;
  int rectSize= random(200,500);
  int xrect = random(3,6);
  int yrect = random(3,6);

// Set the direction.
  digitalWrite(DIR1_PIN, HIGH); 
  digitalWrite(DIR2_PIN, HIGH); 
  delayMicroseconds(DELAY);
  Serial.println(">>");

  for (i = 0; i<rectSize*xrect; i++) // Iterate through steps.
  {
    digitalWrite(STEP1_PIN, HIGH); 
    digitalWrite(STEP1_PIN, LOW); 
    delayMicroseconds(j);
    //j+=1;
  } // particular motor. Any faster the motor stalls.

// Change direction.
  digitalWrite(DIR1_PIN, LOW);
  digitalWrite(DIR2_PIN, LOW); 
  delayMicroseconds(DELAY);

  for (i = 0; i<rectSize*xrect; i++) // Iterate through steps
  {
    digitalWrite(STEP2_PIN, HIGH); 
    digitalWrite(STEP2_PIN, LOW);
    delayMicroseconds(j-1); 
  } 

  for (i = 0; i<rectSize*xrect; i++) 
  {
    digitalWrite(STEP1_PIN, HIGH); 
    digitalWrite(STEP1_PIN, LOW); 
    delayMicroseconds(j-1); 
  } 

  digitalWrite(DIR2_PIN, HIGH); 
  delayMicroseconds(DELAY);

  for (i = 0; i<rectSize*xrect; i++) 
  {
    digitalWrite(STEP2_PIN, LOW); 
    digitalWrite(STEP2_PIN, HIGH); 
    delayMicroseconds(j-1); 
  }
}


void drawTriangle(){
  int triSize= random(500,900);
  int i,j=DELAY;
  digitalWrite(DIR1_PIN, HIGH);
  digitalWrite(DIR2_PIN, LOW); 
  delayMicroseconds(DELAY);
  for ( i = 0; i<triSize*4; i++) 
  {
    digitalWrite(STEP2_PIN, LOW); 
    digitalWrite(STEP2_PIN, HIGH); 
    delayMicroseconds(j); 
  } 
  digitalWrite(DIR1_PIN, LOW); 
  digitalWrite(DIR2_PIN, HIGH);
  delayMicroseconds(DELAY);

  for (i = 0; i<triSize*2; i++) 
  {
    digitalWrite(STEP2_PIN, LOW); 
    digitalWrite(STEP2_PIN, HIGH); 
    digitalWrite(STEP1_PIN, LOW); 
    digitalWrite(STEP1_PIN, HIGH);   
    delayMicroseconds(j-1); 
  }

  digitalWrite(DIR1_PIN, HIGH);
  for (i = 0; i<triSize*2; i++) 
  {
    digitalWrite(STEP2_PIN, LOW); 
    digitalWrite(STEP2_PIN, HIGH); 
    digitalWrite(STEP1_PIN, LOW); 
    digitalWrite(STEP1_PIN, HIGH); 
    delayMicroseconds(j-1); 
  }
}


void drawZigzag() {
  int i,j=DELAY;

  digitalWrite(DIR1_PIN, LOW); 
  digitalWrite(DIR2_PIN, LOW); 
  delayMicroseconds(DELAY);

  for (i = 0; i<1000; i++) 
  {
    digitalWrite(STEP1_PIN, LOW);
    digitalWrite(STEP1_PIN, HIGH); 
    digitalWrite(STEP2_PIN, LOW); 
    digitalWrite(STEP2_PIN, HIGH); 
    digitalWrite(DIR2_PIN, HIGH); 
    digitalWrite(STEP2_PIN, LOW);
    digitalWrite(STEP2_PIN, HIGH); 
    delayMicroseconds(j);
  } 
  digitalWrite(DIR1_PIN, HIGH); 

  for (i = 0; i<1000; i++) 
  {
    digitalWrite(STEP1_PIN, LOW); 
    digitalWrite(STEP1_PIN, HIGH);
    digitalWrite(STEP2_PIN, LOW);
    digitalWrite(STEP2_PIN, LOW); 
    digitalWrite(DIR2_PIN, HIGH); 
    digitalWrite(STEP2_PIN, LOW);
    digitalWrite(STEP2_PIN, HIGH); 
    delayMicroseconds(j); 
  }
}


void drawCircle() {
  float px, py, px2, py2;
  float angle, angle2;
  float radius = random(10, 500);
  float frequency = 2;
  float frequency2 = 2;

  if (stepper1.distanceToGo() == 0) {
    angle -= frequency;
    px = fullLengthX/8 + cos(radians(angle))*(radius);
    px = -px;
    stepper1.moveTo(px*4);
  }
  if (stepper2.distanceToGo() == 0) {
    angle -= frequency;
    py = 75 + sin(radians(angle))*(radius);
    py=-py;
    stepper2.moveTo(py*4);
  }
  stepper2.run();
  stepper1.run();
}



void drawCircle2() {
  int i,j=DELAY;
  if (stepper1.distanceToGo() == 0)
  {
    pos1 = -pos1;
    stepper1.moveTo(pos1);
    delay(100);
  } 

  if (stepper2.distanceToGo() == 0)
  {
    pos2 = -pos2;
    stepper2.moveTo(pos2);
  } 
  stepper2.run();
  stepper1.run();
}





void servoAction(){
  for(pos = 104; pos>=80; pos-=1)     // go from 104 to 80
  {                                
    cameraServo.write(pos);             
  }  
  for(pos = 80; pos < 104; pos += 1) 
  {                                 
    cameraServo.write(pos);                      
  } 
}



