//
//  TrajectoryForm.h
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 3/4/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrajectoryForm : UIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *gunProfilePicker;

@property (weak, nonatomic) IBOutlet UITextField *distanceTextBox;
@property (weak, nonatomic) IBOutlet UITextField *windSpeedTextBox;
@property (weak, nonatomic) IBOutlet UITextField *windDirectionTextBox;
@property (weak, nonatomic) NSMutableArray *gunProfiles;

- (IBAction)calculateTrajectoryButtonEvent:(id)sender;

@end
