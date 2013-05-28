#include "testApp.h"
#include "MyGuiView.h"

MyGuiView * myGuiViewController;


//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
    
	//NOTE WE WON'T RECEIVE TOUCH EVENTS INSIDE OUR APP WHEN THERE IS A VIEW ON TOP OF THE OF VIEW
    
	lengthRatio	= 0.5;
	numPoints	= 5;
	bFill		= true;
	
	//Our Gui setup
	myGuiViewController	= [[MyGuiView alloc] initWithNibName:@"MyGuiView" bundle:nil];
	[ofxiPhoneGetUIWindow() addSubview:myGuiViewController.view];
    
	ofBackground(0);
    
    blueShape = true;
    
    // initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
    
    // added this from openAl example
    ofSetFrameRate(30);
    
    childrenSounds.loadSound("children.wav");
    ambientSounds.loadSound("ambient.wav");
    construction.loadSound("construction.wav");
    rainWav.loadSound("Rain.wav");
    birds.loadSound("birdsSm.wav");
    //train.loadSound("train.wav");
    
    sewingMusic.loadSound("sewingMusic.wav");
    boatThunder.loadSound("boatThunder.wav");
    highLine.loadSound("highline.wav");
    
    //boo.loadSound("boo.wav");
    //cheer.loadSound("cheer.wav");
    
    sample1 = &sewingMusic;
    sample2 = &sewingMusic;
    
    sample3 = &boatThunder;
    sample4 = &boatThunder;
    
    sample5 = &highLine;
    sample6 = &highLine;
    
    //sample1 = &construction;
    //sample2 = &miller;
    //sample2 = &sewing;
    //    sample3 = &rainWav;
    //    sample4 = &ambientSounds;
    //    sample5 = &birds;
    //    sample6 = &train;
    //sample5 = &train;
    //sample6 = &train;
    //sample4 = &construction;
    //sample5 = &thunder;
    //sample6 = &birds;
    //sample5 = &construction;
    //sample5 = &construction;
    //sample6 = &rainWav;
    
    // sample7 = &construction;
    sample9 = &birds;
    sample10 = &birds;
    
    minForce = 0;
    maxForce = 0;
    
    largeSampleTotal=0;
    input = 0;
    
    soundOption1 = false;
    soundOption2 = false;
    soundOption3 = false;
    
    soundOption1Old = false;
    soundOption2Old = false;
    soundOption3Old = false;
    
    startDelay = 3000;
}

//--------------------------------------------------------------
void testApp::update(){
    //printf("x = %f   y = %f   z= %f   angle= %f ", ofxAccelerometer.getForce().x, fabs(ofxAccelerometer.getForce().y), ofxAccelerometer.getForce().z, angle);
    
    //volumeAdjustOneTrack(sample1);
    //volumeAdjustTwoTracks(sample1, sample2);
    //thresholdTest(sample1, sample2);
    
}

//--------------------------------------------------------------
void testApp::draw(){
    
    //printf("soundOption1 = %i, soundOption1Old = %i \n", soundOption1, soundOption1Old);
    //printf("soundOption2 = %i, soundOption2Old = %i \n", soundOption2, soundOption2Old);
    //printf("soundOption3 = %i, soundOption3Old = %i \n", soundOption3, soundOption3Old);
    
    if(soundOption1) {
        //if(soundOption1 != soundOption1Old){
        // ofSleepMillis(startDelay);
        //}
        //thresholdTest(sample1, sample2, 0.002, 0.075, 0.15, 0.2, 0.5, 1);
        //thresholdTest(sample1, sample2, 0.001, 0.01, 0.05, 0.15, 0.2, 0.6, 1);
        //thresholdTest(sample1, sample2, 0, 0.01, 0.05, 0.15, 0.2, 0.6, 1);
        //thresholdTest(sample1, sample2, 0, 0.01, 0.05, 0.15, 0.25, 0.8, 1);
        
        runningAverage(sample1, sample2, 1, 1.005, 1.005, 1.05, 1.1, 1, 1);
        //runningAverage(sample1, sample2, 1, 1.01, 1.01, 1.06, 1.1, 0.8, 1);
        
    } 
    
    else {
        sample1->stop();
        sample2->stop();
    }
    
    if(soundOption2) {
        //if(soundOption2 != soundOption2Old){
        //  ofSleepMillis(startDelay);
        // }
        //thresholdTest(sample3, sample4, 0.001, 0.075, 0.05, 0.15, 0.2, 0.6, 1);
        //thresholdTest(sample3, sample4, 0.0005, 0.01, 0.04, 0.15, 0.2, 0.9, 1);
        //thresholdTest(sample3, sample4, 0, 0.01, 0.04, 0.15, 0.2, 0.9, 1);
        runningAverage(sample3, sample4, 1, 1.005, 1.005, 1.05, 1.1, 1, 1);    } 
    
    else 
    {
        sample3->stop();
        sample4->stop();
    }
    
    if(soundOption3) {
        //if(soundOption3 != soundOption3Old){
        //    ofSleepMillis(startDelay);
        //}
        //thresholdTest(sample5, sample6, 0.001, 0.075, 0.05, 0.15, 0.2, 0.6, 1);
        //thresholdTest(sample5, sample6, 0.0005, 0.01, 0.05, 0.15, 0.2, 0.9, 1);
        //thresholdTest(sample5, sample6, 0, 0.01, 0.05, 0.15, 0.2, 0.9, 1);
        runningAverage(sample5, sample6, 1, 1.005, 1.005, 1.05, 1.1, 1, 1);    } 
    
    else {
        sample5->stop();
        sample6->stop();
    }
    
    if(soundOption4) {
        if(soundOption4 != soundOption4Old){
            ofSleepMillis(startDelay);
        }
        //thresholdTest(sample9, sample10, 0.002, 0.075, 0.075, 0.15, 0.2, 0.9, 1);
    } 
    
    else {
        sample9->stop();
        sample10->stop();
    }
    
    soundOption1Old = soundOption1;
    soundOption2Old = soundOption2;
    soundOption3Old = soundOption3;
    soundOption4Old = soundOption4;
    
}

// not used
void testApp::volumeAdjustOneTrack(ofxOpenALSoundPlayer *sample){
    
    float adjustedVolume = ofMap(fabs(ofxAccelerometer.getForce().y) * fabs(ofxAccelerometer.getForce().y), 0, 1.1, 0, 1);
    sample1->setVolume(adjustedVolume);
    if(sample1->getIsPlaying() == false) sample->play();
    
}


// not used
void testApp::volumeAdjustTwoTracks(ofxOpenALSoundPlayer *sample1, ofxOpenALSoundPlayer *sample2){
    
    float adjustedVolume = ofMap(fabs(ofxAccelerometer.getForce().y) * fabs(ofxAccelerometer.getForce().y), 0, 1.1, 0, 1);
    
    sample1->setVolume(1-adjustedVolume);
    sample2->setVolume(adjustedVolume);
    
    //printf("adjustedVolume = %f, ofxAccelerometer.getForce().y = %f \n", adjustedVolume, ofxAccelerometer.getForce().y);
    
    if(sample2->getIsPlaying() == false) sample2->play();
    if(sample1->getIsPlaying() == false) sample1->play();
}


void testApp::runningAverage(ofxOpenALSoundPlayer *sample1, ofxOpenALSoundPlayer *sample2, float minHeightSample1, float maxHeightSample1, float minHeightSample2, float maxHeightSample2, float maxHeight, float maxVolumeSample1, float maxVolumeSample2){
    
    
    ofxAccelerometer.setForceSmoothing(1);
    ofxAccelerometer.setOrientationSmoothing(0.05);
    float accelerometerX = ofxAccelerometer.getForce().x; // useless on its own
    float accelerometerY = ofxAccelerometer.getForce().y;
    float accelerometerZ = ofxAccelerometer.getForce().z;
    float combinedAccel = sqrt((accelerometerX * accelerometerX) + (accelerometerY * accelerometerY) + (accelerometerZ * accelerometerZ));
    
    //float pitch = ofxAccelerometer.getOrientation().x;
    
    //CHANGE ARRAY SIZE IN HEADER FILE AS WELL
    int runningAvgSize = 100;
    
    float volumeOne = 0;
    float volumeTwo = 0;
    
    runningAvg[0] = combinedAccel;
    
    for(int i=0; i < runningAvgSize; i++) {
        runningAvgTotal += runningAvg[i];
    }
    
    // the initial 3 second delay after the launch of the application
    // ideally, link this to eventhandler within objective c gui
    //if(runningAvg[0]-runningAvg[1] == runningAvg[0]) ofSleepMillis(3000);
    
    runningAvgAverage = runningAvgTotal/runningAvgSize;
    runningAvgTotal = 0;
    
    for (int i = runningAvgSize; i>0; i--){
        runningAvg[i]=runningAvg[i-1];
    }
    
    runningAvg[0] = 0;
    
    //if (rollingInputAverage < min) {
    if (runningAvgAverage < minHeightSample1) {
        volumeOne = 0;
        volumeTwo = 0;
    }
    
    //else if (rollingInputAverage >= min && rollingInputAverage <= maxHeightSample1) {
    else if (runningAvgAverage >= minHeightSample1 && runningAvgAverage <= maxHeightSample1) {
        volumeOne = ofMap(runningAvgAverage, minHeightSample1, maxHeightSample1, 0, maxVolumeSample1);
        volumeTwo = 0;
        
        //volumeOne = ofMap(rollingInputAverage, min, maxHeightSample1, 0, maxVolumeSample1);
        //volumeTwo = volumeTwo = ofMap(rollingInputAverage, min, maxHeightSample2,0,1);;
    }
    
    else if (runningAvgAverage > maxHeightSample1 && runningAvgAverage < maxHeightSample2) {
        //volumeOne = ofMap(rollingInputAverage, maxHeightSample1, maxHeightSample2,maxVolumeSample1,0);
        volumeOne = ofMap(runningAvgAverage, maxHeightSample1, maxHeight,maxVolumeSample1,0);
        volumeTwo = ofMap(runningAvgAverage, minHeightSample1, maxHeightSample2,0,maxVolumeSample2);
        //volumeTwo = ofMap(rollingInputAverage, min, maxHeightSample2,0,1);
    }
    
    else if (runningAvgAverage >= maxHeightSample2 && runningAvgAverage <= maxHeight) {
        volumeOne = 0;
        volumeTwo = ofMap(runningAvgAverage, maxHeightSample2, maxHeight,maxVolumeSample2, 0);
        //volumeTwo = maxVolumeSample2;
    }
    
    else if (runningAvgAverage > maxHeight) {
        volumeTwo = 0;
    }
    
    sample1->setVolume(volumeOne);
    sample2->setVolume(volumeTwo);
    
    if(sample2->getIsPlaying() == false) sample2->play();
    if(sample1->getIsPlaying() == false) sample1->play();
    
    
    printf("%f, %f, %f, %f \n", combinedAccel, runningAvgAverage, volumeOne, volumeTwo);
    
}



//USED
void testApp::thresholdTest(ofxOpenALSoundPlayer *sample1, ofxOpenALSoundPlayer *sample2, float minHeightSample1, float maxHeightSample1, float minHeightSample2, float maxHeightSample2, float maxHeight, float maxVolumeSample1, float maxVolumeSample2) {
    
    ofxAccelerometer.setForceSmoothing(1);
    ofxAccelerometer.setOrientationSmoothing(0.05);
    
    float accelerometerX = ofxAccelerometer.getForce().x; // useless on its own
    float accelerometerY = ofxAccelerometer.getForce().y;
    float accelerometerZ = ofxAccelerometer.getForce().z;
    
    float combinedAccel = sqrt((accelerometerX * accelerometerX) + (accelerometerY * accelerometerY) + (accelerometerZ * accelerometerZ));
    
    
    float pitch = ofxAccelerometer.getOrientation().x;
    float roll = ofxAccelerometer.getOrientation().y; // useless
    
    //float min = 0.002;
    //float maxHeightSample2 = 0.2;
    //float maxHeightSample1 = 0.08;
    
    //float maxHeightSample2 = 0.15;
    //float maxHeightSample1 = 0.075;
    
    
    //CHANGE ARRAY SIZE IN HEADER FILE AS WELL
    int largeSampleSize = 60;
    int smallSampleSize = 6;
    int sampleSizeInput = 50; //50 WORKS WELL
    int largeSampleDiffSize = 10;
    
    
    float volumeOne = 0;
    float volumeTwo = 0;
    
    //bool hasStarted = true;
    //bool hasEnded = false;
    
    
    if (accelerometerY > -0.078) {
        
        smallSample[0] = accelerometerY;
        largeSample[0] = accelerometerY;    
        
        for(int i=0; i < smallSampleSize; i++) {
            smallSampleTotal += smallSample[i];
        }
        
        
        // the initial 3 second delay after the launch of the application
        // ideally, link this to eventhandler within objective c gui
        if(smallSample[0]-smallSample[1] == smallSample[0]) ofSleepMillis(3000);
        
        
        //float sampleDifference = fabs(smallSample[0]-smallSample[smallSampleSize-1]);
        //float sampleDifference2 = fabs(smallSample[0]-smallSampleAverage);
        
        smallSampleAverage = smallSampleTotal/smallSampleSize;
        smallSampleTotal = 0;
        
        
        // small sample to smoth out the accelerometer data values, 6 implies 1/5 of a second
        for (int i = smallSampleSize; i>0; i--){
            smallSample[i]=smallSample[i-1];
        }
        
        smallSample[0] = 0;
        
        // large sample to look at values over the last swing interval, which lasts about 1.6 seconds
        for (int i = 0; i < largeSampleSize; i++) {
            largeSampleTotal += largeSample[i];
        }
        
        largeSampleAverage = largeSampleTotal/largeSampleSize;
        largeSampleTotal = 0;
        
        // large sample diff to detect stopping of motion over 1/3 of a second, to see when someone stops swinging 
        for (int i = 0; i < largeSampleDiffSize; i++) {
            largeSampleDiff[i] = fabs(largeSample[i]-largeSample[i+10]);
            largeSampleDiffTotal += largeSampleDiff[i]; 
            
        }
        
        largeSampleDiffAverage = largeSampleDiffTotal/largeSampleDiffSize;
        largeSampleDiffTotal = 0;
        
        for (int i =  largeSampleDiffSize; i>0; i--){
            largeSampleDiff[i]=largeSampleDiff[i-1];
        }
        
        
        for (int i = largeSampleSize; i>0; i--){
            largeSample[i]=largeSample[i-1];
        }
        
        largeSample[0]=0;
        
    }
    
    rollingInput[0] = fabs(largeSampleAverage-smallSampleAverage);
    
    
    for (int i = 0; i <  sampleSizeInput; i++) {
        rollingInputTotal += rollingInput[i];
    }
    
    rollingInputAverage = rollingInputTotal/ sampleSizeInput;
    rollingInputTotal = 0;
    
    for (int i =  sampleSizeInput; i>0; i--){
        rollingInput[i]=rollingInput[i-1];
    }
    
    rollingInput[0]=0;
    
    //if (rollingInputAverage < min) {
    if (rollingInputAverage < minHeightSample1) {
        volumeOne = 0;
        volumeTwo = 0;
    }
    
    //else if (rollingInputAverage >= min && rollingInputAverage <= maxHeightSample1) {
    else if (rollingInputAverage >= minHeightSample1 && rollingInputAverage <= maxHeightSample1) {
        volumeOne = ofMap(rollingInputAverage, minHeightSample1, maxHeightSample1, 0, maxVolumeSample1);
        volumeTwo = 0;
        
        //volumeOne = ofMap(rollingInputAverage, min, maxHeightSample1, 0, maxVolumeSample1);
        //volumeTwo = volumeTwo = ofMap(rollingInputAverage, min, maxHeightSample2,0,1);;
    }
    
    else if (rollingInputAverage > maxHeightSample1 && rollingInputAverage < maxHeightSample2) {
        //volumeOne = ofMap(rollingInputAverage, maxHeightSample1, maxHeightSample2,maxVolumeSample1,0);
        volumeOne = ofMap(rollingInputAverage, maxHeightSample1, maxHeight,maxVolumeSample1,0);
        volumeTwo = ofMap(rollingInputAverage, minHeightSample1, maxHeightSample2,0,maxVolumeSample2);
        //volumeTwo = ofMap(rollingInputAverage, min, maxHeightSample2,0,1);
    }
    
    else if (rollingInputAverage >= maxHeightSample2 && rollingInputAverage <= maxHeight) {
        volumeOne = 0;
        volumeTwo = ofMap(rollingInputAverage, maxHeightSample2, maxHeight,maxVolumeSample2, 0);
        //volumeTwo = maxVolumeSample2;
    }
    
    else if (rollingInputAverage > maxHeight) {
        volumeTwo = 0;
    }
    
    
    // if someone stops swinging
    if(largeSampleDiffAverage < 0.01){
        volumeOne = 0;
        volumeTwo = 0;
    }
    
    sample1->setVolume(volumeOne);
    sample2->setVolume(volumeTwo);
    
    if(sample2->getIsPlaying() == false) sample2->play();
    if(sample1->getIsPlaying() == false) sample1->play();
    
    
    //printf("%f, %f, %f, %f, %f \n", rollingInputAverage, volumeOne, volumeTwo, accelerometerY, largeSampleDiffAverage);
    
    printf("%f, %f, %f, %f, %f, %f \n", accelerometerX, accelerometerY, accelerometerZ, pitch, roll, combinedAccel);
    
}


/*
 void testApp::volumeScale(ofxOpenALSoundPlayer *sample1, ofxOpenALSoundPlayer *sample2){
 }
 */

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
    
	//IF THE VIEW IS HIDDEN LETS BRING IT BACK!
	if( myGuiViewController.view.hidden ){
		myGuiViewController.view.hidden = NO;
	}
	
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){
    
}

