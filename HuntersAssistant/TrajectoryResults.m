//
//  TrajectoryResults.m
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 3/4/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import "TrajectoryResults.h"
#import "XMLFileFunctions.h"
#import "TrajectoryCalculator.h"
#import "CalibrationFormPage1.h"

@interface TrajectoryResults ()

@end

@implementation TrajectoryResults

@synthesize distance;
@synthesize windDirection;
@synthesize windSpeed;
@synthesize gunProfile;
@synthesize verticalChangeLabel;
@synthesize horizontalChangeLabel;

XMLFileFunctions *xmlFunctions;
TrajectoryCalculator *calculator;
double verticalChange;
double horizontalChange;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	calculator = [[TrajectoryCalculator alloc] init];
    verticalChange = [calculator calculateBulletDropWithBallisticCoefficient:gunProfile.ballisticCoefficient initialVelocity:gunProfile.initialVelocity range:distance zeroRange:gunProfile.zeroRange sightHeight:gunProfile.sightHeight];
    horizontalChange = [calculator calculateWindageWithBallisticCoefficient:gunProfile.ballisticCoefficient windSpeed:windSpeed range:distance initialVelocity:gunProfile.initialVelocity windAngle:windDirection];
    
    NSString *verticalChangeText = [NSString stringWithFormat:@"%f", verticalChange];
    NSString *horizontalChangeText = [NSString stringWithFormat:@"%f", horizontalChange];
    verticalChangeLabel.text = [verticalChangeText stringByAppendingString:@" inches"];
    horizontalChangeLabel.text = [horizontalChangeText stringByAppendingString:@" inches"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calibrateCalculatorButtonEvent:(id)sender {
    [self performSegueWithIdentifier:@"calibrateCalculator" sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString: @"calibrateCalculator"])
    {
        CalibrationFormPage1 *destination = [segue destinationViewController];
        destination.distance = distance;
        destination.windDirection = windDirection;
        destination.windSpeed = windSpeed;
        destination.verticalChange = verticalChange;
        destination.horizontalChange = horizontalChange;
        destination.profile = gunProfile;
    }
}

@end
