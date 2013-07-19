//
//  AddEditGunProfileForm.h
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 2/21/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GunProfile.h"

@interface AddEditGunProfileForm : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *profileNameTextBox;

@property (weak, nonatomic) IBOutlet UITextField *ballisticCoefficientTextBox;

@property (weak, nonatomic) IBOutlet UITextField *initialVelocityTextBox;

@property (weak, nonatomic) IBOutlet UITextField *zeroRangeTextBox;

@property (weak, nonatomic) IBOutlet UITextField *sightHeightTextBox;
@property (weak, nonatomic) NSMutableArray *gunProfiles;
@property (weak, nonatomic) GunProfile *currentProfile;
- (IBAction)saveProfile:(id)sender;

@end
