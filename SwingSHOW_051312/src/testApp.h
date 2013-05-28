#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxOpenALSoundPlayer.h"

class testApp : public ofxiPhoneApp {
	
public:
	
	float lengthRatio;
	int numPoints;
	bool bFill;
    
    bool blueShape;
    
	
	void setup();
	void update();
	void draw();
    
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	void touchCancelled(ofTouchEventArgs &touch);
    
    void volumeAdjustOneTrack(ofxOpenALSoundPlayer *sample);
    
    void volumeAdjustTwoTracks(ofxOpenALSoundPlayer *sample1, ofxOpenALSoundPlayer *sample2);
    
    void thresholdTest(ofxOpenALSoundPlayer *sample1, ofxOpenALSoundPlayer *sample2, float minHeightSample1, float maxHeightSample1, float minHeightSample2, float maxHeightSample2, float maxHeight, float maxVolumeSample1, float maxVolumeSample2);
    
    void runningAverage(ofxOpenALSoundPlayer *sample1, ofxOpenALSoundPlayer *sample2, float minHeightSample1, float maxHeightSample1, float minHeightSample2, float maxHeightSample2, float maxHeight, float maxVolumeSample1, float maxVolumeSample2);
    
    //void volumeScale(ofxOpenALSoundPlayer *sample1, ofxOpenALSoundPlayer *sample2);
    
    
    ofxOpenALSoundPlayer childrenSounds;
    ofxOpenALSoundPlayer ambientSounds;
    
    ofxOpenALSoundPlayer rainWav;
    
    ofxOpenALSoundPlayer birds;
    ofxOpenALSoundPlayer construction;
    ofxOpenALSoundPlayer train;
    
    ofxOpenALSoundPlayer sewingMusic;
    ofxOpenALSoundPlayer boatThunder;
    ofxOpenALSoundPlayer highLine;
    
    ofxOpenALSoundPlayer *sample1;
    ofxOpenALSoundPlayer *sample2;
    ofxOpenALSoundPlayer *sample3;
    ofxOpenALSoundPlayer *sample4;
    ofxOpenALSoundPlayer *sample5;
    ofxOpenALSoundPlayer *sample6;
    ofxOpenALSoundPlayer *sample7;
    ofxOpenALSoundPlayer *sample8;
    ofxOpenALSoundPlayer *sample9;
    ofxOpenALSoundPlayer *sample10;
    
    float minForce;
    float maxForce;
    
    float smallSample[6]; 
    //float rollingAverageMin[10];
    
    float runningAvg[100]; 
    
    float largeSample[60];
    
    float   runningAvgTotal;
    float   runningAvgAverage;
    
    
    float   smallSampleTotal;
    float   smallSampleAverage;
    float   lastSmallSampleAverage;
    
    float largeSampleDiff[10];
    
    float largeSampleDiffTotal;
    float largeSampleDiffAverage;
    
    float startDelay; // in milisecs
    
    
    //float   counterOne;
    //float   counterTwo;
    
    //float   minForceTotal;
    //float   minForceAverage;
    
    
    //float   dataTotal;
    //float   dataTotalAverage;
    //int     totalCounter;
    
    float largeSampleTotal;
    float largeSampleAverage;
    
    float input; 
    float rollingInput[50];
    float rollingInputAverage;
    float rollingInputTotal;
    
    bool soundOption1;
    bool soundOption2;
    bool soundOption3;
    bool soundOption4;
    
    bool soundOption1Old;
    bool soundOption2Old;
    bool soundOption3Old;
    bool soundOption4Old;
};



