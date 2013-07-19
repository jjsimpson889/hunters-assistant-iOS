//
//  TrajectoryResults.h
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 3/4/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GunProfile.h"

@interface TrajectoryResults : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *verticalChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *horizontalChangeLabel;
@property (atomic) double distance;
@property (atomic) double windSpeed;
@property (atomic) double windDirection;
@property (weak, nonatomic) GunProfile* gunProfile;

- (IBAction)calibrateCalculatorButtonEvent:(id)sender;

@end
