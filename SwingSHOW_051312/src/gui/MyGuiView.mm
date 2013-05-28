//
//  MyGuiView.m
//  iPhone Empty Example
//
//  Created by theo on 26/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyGuiView.h"
#include "ofxiPhoneExtras.h"


@implementation MyGuiView




// called automatically after the view is loaded, can be treated like the constructor or setup() of this class

-(void)viewDidLoad {
	myApp = (testApp*)ofGetAppPtr();
}

//----------------------------------------------------------------
-(void)setStatusString:(NSString *)trackStr{
	displayText.text = trackStr;
}

//----------------------------------------------------------------
-(IBAction)more:(id)sender{
	myApp->lengthRatio += 0.1;
	
	string statusStr = " Status: ratio is " + ofToString(myApp->lengthRatio, 2);
	[self setStatusString:ofxStringToNSString(statusStr)];		
}

//----------------------------------------------------------------
-(IBAction)less:(id)sender{
	myApp->lengthRatio -= 0.1;
	if( myApp->lengthRatio < 0.1 ){
		myApp->lengthRatio = 0.1;
	}

	string statusStr = " Status: ratio is " + ofToString(myApp->lengthRatio, 2);
	[self setStatusString:ofxStringToNSString(statusStr)];		
}

//----------------------------------------------------------------
-(IBAction)hide:(id)sender{
	self.view.hidden = YES;
}

//----------------------------------------------------------------
-(IBAction)adjustPoints:(id)sender{
	
	UISlider * slider = sender;
	printf("slider value is - %f\n", [slider value]);
	
	myApp->numPoints = 3 + [slider value] * 28;
	
	string statusStr = " Status: numPoints is " + ofToString(myApp->numPoints);
	[self setStatusString:ofxStringToNSString(statusStr)];
	
}


//----------------------------------------------------------------
-(IBAction)fillSwitch:(id)sender{
	
	UISwitch * toggle = sender;
	printf("switch value is - %i\n", [toggle isOn]);
	
	myApp->bFill = [toggle isOn];
	
	string statusStr = " Status: fill is " + ofToString(myApp->bFill);
	[self setStatusString:ofxStringToNSString(statusStr)];	
}

//----------------------------------------------------------------
-(IBAction)toggleColor:(id)sender{
	
	UISwitch * newToggle = sender;
	printf("switch value is - %i\n", [newToggle isOn]);
	
	myApp->blueShape = [newToggle isOn];
	
	string statusStr = " Status: fill is " + ofToString(myApp->blueShape);
	[self setStatusString:ofxStringToNSString(statusStr)];	
}

//----------------------------------------------------------------
-(IBAction)switchSounds:(id)sender{
	
	UISwitch * newToggle = sender;
	printf("switch value is - %i\n", [newToggle isOn]);
	
	myApp->soundOption1 = [newToggle isOn];
	
	string statusStr = " Status: fill is " + ofToString(myApp->soundOption1);
	[self setStatusString:ofxStringToNSString(statusStr)];	
}
 /*

-(IBAction)ButtonPressed1:(id)sender{
    
    
    
    UIButton *newButton = sender;
	myApp->soundOption1 = [newButton isTouchInside];
   
	myApp->soundOption1 = [newButton isTouchInside];
    
    
	string statusStr = " Status: fill is " + ofToString(myApp->soundOption1);
	[self setStatusString:ofxStringToNSString(statusStr)];	
	
}

-(IBAction)ButtonPressed2:(id)sender{
    
    UIButton *newButton = sender;
	myApp->soundOption2 = [newButton isTouchInside];
    
	
	string statusStr = " Status: fill is " + ofToString(myApp->soundOption1);
	[self setStatusString:ofxStringToNSString(statusStr)];	
	
}

-(IBAction)ButtonPressed3:(id)sender{
    
    UIButton *newButton = sender;
	myApp->soundOption3 = [newButton isTouchInside];
    
	
	string statusStr = " Status: fill is " + ofToString(myApp->soundOption1);
	[self setStatusString:ofxStringToNSString(statusStr)];	
	
}
*/


//----------------------------------------------------------------
-(IBAction)switchSounds2:(id)sender{
	
	UISwitch * newToggle = sender;
	printf("switch value is - %i\n", [newToggle isOn]);
	
	myApp->soundOption2 = [newToggle isOn];
	
	string statusStr = " Status: fill is " + ofToString(myApp->soundOption2);
	[self setStatusString:ofxStringToNSString(statusStr)];	
}
//----------------------------------------------------------------
-(IBAction)switchSounds3:(id)sender{
	
	UISwitch * newToggle = sender;
	printf("switch value is - %i\n", [newToggle isOn]);
	
	myApp->soundOption3 = [newToggle isOn];
	
	string statusStr = " Status: fill is " + ofToString(myApp->soundOption3);
	[self setStatusString:ofxStringToNSString(statusStr)];	
}



-(IBAction)goTo:(id)sender
{

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/"]];
    
}

@end
