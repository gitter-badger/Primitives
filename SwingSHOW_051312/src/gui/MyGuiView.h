//
//  MyGuiView.h
//  iPhone Empty Example
//
//  Created by theo on 26/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "testApp.h"

@interface MyGuiView : UIViewController {
  
    
	IBOutlet UILabel *displayText;
	
/*@property (retain, nonatomic) IBOutlet UILabel *pierLabel;
  */  
	testApp *myApp;		// points to our instance of testApp
}

-(void)setStatusString:(NSString *)trackStr;

-(IBAction)adjustPoints:(id)sender;
-(IBAction)fillSwitch:(id)sender;

-(IBAction)toggleColor:(id)sender;
-(IBAction)switchSounds:(id)sender;
-(IBAction)switchSounds2:(id)sender;
-(IBAction)switchSounds3:(id)sender;
-(IBAction)goTo:(id)sender;
/*
-(IBAction)ButtonPressed1:(id)sender;


-(IBAction)ButtonPressed2:(id)sender;


-(IBAction)ButtonPressed3:(id)sender;
*/
-(IBAction)more:(id)sender;
-(IBAction)less:(id)sender;

-(IBAction)hide:(id)sender;

@end
