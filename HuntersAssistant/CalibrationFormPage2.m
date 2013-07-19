//
//  CalibrationFormPage2.m
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 3/4/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import "CalibrationFormPage2.h"
#import "GunProfile.h"
#import "XMLFileFunctions.h"
#import "TrajectoryCalculator.h"

@interface CalibrationFormPage2 ()

@end

@implementation CalibrationFormPage2

@synthesize gunProfilePicker;
@synthesize distanceTextBox;
@synthesize windSpeedTextBox;
@synthesize windDirectionTextBox;
@synthesize verticalChangeTextBox;
@synthesize horizontalChangeTextBox;
@synthesize gunProfiles;

@synthesize range;
@synthesize firstProfile;
@synthesize windDirection;
@synthesize windSpeed;
@synthesize realVerticalResult;
@synthesize realHorizontalResult;

XMLFileFunctions *xmlFunctions;
double secondRange;
double secondWindDirection;
double secondWindSpeed;
double secondRealVerticalResult;
double secondRealHorizontalResult;
GunProfile *secondProfile;
GunProfile *myGunProfile;
TrajectoryCalculator *calculator;

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
	xmlFunctions = [XMLFileFunctions alloc];
    NSString *xmlString = [xmlFunctions readStringFromFile];
    gunProfiles = [xmlFunctions parseGunProfileXMLString:xmlString];
    myGunProfile = firstProfile;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString: @"calibrate"])
    {
        secondRange = [distanceTextBox.text doubleValue];
        secondWindSpeed = [windSpeedTextBox.text doubleValue];
        secondWindDirection = [windDirectionTextBox.text doubleValue];
        secondRealHorizontalResult = [horizontalChangeTextBox.text doubleValue];
        secondRealVerticalResult = [verticalChangeTextBox.text doubleValue];
        calculator = [[TrajectoryCalculator alloc]init];
        double TF = [calculator calculateTimeOfFlightWithBallisticCoefficient:myGunProfile.ballisticCoefficient initialVelocity:myGunProfile.initialVelocity range:range];
        double secondTF = [calculator calculateTimeOfFlightWithBallisticCoefficient:secondProfile.ballisticCoefficient initialVelocity:secondProfile.initialVelocity range:secondRange];
        [calculator calibrateCalculatorWithBallisticCoefficient:myGunProfile.ballisticCoefficient realVerticalResult:realVerticalResult realHorizontalResult:realHorizontalResult secondRealHorizontalResult:secondRealHorizontalResult windSpeed:windSpeed secondWindSpeed:secondWindSpeed windAngle:windDirection secondWindAngle:secondWindDirection timeOfFlight:TF secondTimeOfFlight:secondTF initialVelocity:myGunProfile.initialVelocity secondInitialVelocity:secondProfile.initialVelocity range:range secondRange:secondRange zeroRange:myGunProfile.zeroRange sightHeight:myGunProfile.sightHeight];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return [gunProfiles count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    GunProfile *profile = [gunProfiles objectAtIndex:row];
    return profile.profileName;
}

- (bool)validateDecimalInput: (NSString *) input
{
    bool isValid = false;
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d)+(\\.(\\d)+)?"
                                                                           options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:input options:0 range:NSMakeRange(0, [input length])];
    isValid = numberOfMatches == 1;
    
    return isValid;
}

- (IBAction)validateInputEvent:(id)sender {
    NSInteger row = [gunProfilePicker selectedRowInComponent:0];
    secondProfile = [gunProfiles objectAtIndex:row];
    if([self validateDecimalInput:distanceTextBox.text] && [self validateDecimalInput:windSpeedTextBox.text] && [self validateDecimalInput:windDirectionTextBox.text] && secondProfile != nil && [self validateDecimalInput: verticalChangeTextBox.text] && [self validateDecimalInput: horizontalChangeTextBox.text])
    {
        [self performSegueWithIdentifier:@"calibrate" sender:sender];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid input" message:@"The form must include all valid input before continuing" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
}
@end
