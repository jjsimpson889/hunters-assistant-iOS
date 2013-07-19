//
//  TrajectoryForm.m
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 3/4/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import "TrajectoryForm.h"
#import "TrajectoryResults.h"
#import "XMLFileFunctions.h"
#import "TrajectoryCalculator.h"
#import "GunProfile.h"

@interface TrajectoryForm ()

@end

@implementation TrajectoryForm

@synthesize gunProfilePicker;
@synthesize distanceTextBox;
@synthesize windDirectionTextBox;
@synthesize windSpeedTextBox;
@synthesize gunProfiles;
XMLFileFunctions *xmlFunctions;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateTrajectoryButtonEvent:(id)sender {
    
    NSInteger row = [gunProfilePicker selectedRowInComponent:0];
    GunProfile *selectedValue = [gunProfiles objectAtIndex:row];
    if([self validateDecimalInput:distanceTextBox.text] && [self validateDecimalInput:windSpeedTextBox.text] && [self validateDecimalInput:windDirectionTextBox.text] && selectedValue != nil)
    {
        [self performSegueWithIdentifier:@"calculateTrajectory" sender:sender];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid input" message:@"The form must include all valid input before continuing" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSInteger row = [gunProfilePicker selectedRowInComponent:0];
    GunProfile *selectedValue = [gunProfiles objectAtIndex:row];
    
    TrajectoryResults *destination = [segue destinationViewController];
    destination.gunProfile = selectedValue;
    destination.distance = [distanceTextBox.text doubleValue];
    destination.windSpeed = [windSpeedTextBox.text doubleValue];
    destination.windDirection = [windDirectionTextBox.text doubleValue];
    
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
@end
