//
//  CalibrationFormPage1.h
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 3/4/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GunProfile.h"

@interface CalibrationFormPage1 : UIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *gunProfilePicker;
@property (weak, nonatomic) IBOutlet UITextField *distanceTextBox;
@property (weak, nonatomic) IBOutlet UITextField *windSpeedTextBox;
@property (weak, nonatomic) IBOutlet UITextField *windDirectionTextBox;
@property (weak, nonatomic) IBOutlet UITextField *verticalChangeTextBox;
@property (weak, nonatomic) IBOutlet UITextField *horizontalChangeTextBox;
@property (weak, nonatomic) NSMutableArray *gunProfiles;
@property (weak, nonatomic) GunProfile *profile;
@property (atomic) double distance;
@property (atomic) double windSpeed;
@property (atomic) double windDirection;
@property (atomic) double verticalChange;
@property (atomic) double horizontalChange;
- (IBAction)validateInput:(id)sender;

@end
