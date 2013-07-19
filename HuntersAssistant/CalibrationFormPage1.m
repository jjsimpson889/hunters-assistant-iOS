//
//  CalibrationFormPage1.m
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 3/4/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import "CalibrationFormPage1.h"
#import "XMLFileFunctions.h"
#import "CalibrationFormPage2.h"

@interface CalibrationFormPage1 ()

@end

@implementation CalibrationFormPage1

@synthesize gunProfilePicker;
@synthesize distanceTextBox;
@synthesize windSpeedTextBox;
@synthesize windDirectionTextBox;
@synthesize verticalChangeTextBox;
@synthesize horizontalChangeTextBox;
@synthesize gunProfiles;

@synthesize profile;
@synthesize distance;
@synthesize windSpeed;
@synthesize windDirection;
@synthesize horizontalChange;
@synthesize verticalChange;
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
	distanceTextBox.text = [NSString stringWithFormat:@"%f",distance];
    windSpeedTextBox.text = [NSString stringWithFormat:@"%f",windSpeed];
    windDirectionTextBox.text = [NSString stringWithFormat:@"%f",windDirection];
    for(int i = 0; i < [gunProfiles count]; i++)
    {
        GunProfile *gun = [gunProfiles objectAtIndex:i];
        if([gun.profileName isEqualToString: profile.profileName])
        {
            [gunProfilePicker selectRow:i inComponent:0 animated:NO];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSInteger row = [gunProfilePicker selectedRowInComponent:0];
    GunProfile *selectedValue = [gunProfiles objectAtIndex:row];
    CalibrationFormPage2 *destination = [segue destinationViewController];
    destination.range = distance;
    destination.windDirection = windDirection;
    destination.windSpeed = windSpeed;
    destination.realVerticalResult = [verticalChangeTextBox.text doubleValue];
    destination.realHorizontalResult = [horizontalChangeTextBox.text doubleValue];
    destination.firstProfile = selectedValue;
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



- (IBAction)validateInput:(id)sender {
    
    NSInteger row = [gunProfilePicker selectedRowInComponent:0];
    profile = [gunProfiles objectAtIndex:row];
    if([self validateDecimalInput:distanceTextBox.text] && [self validateDecimalInput:windSpeedTextBox.text] && [self validateDecimalInput:windDirectionTextBox.text] && profile != nil && [self validateDecimalInput: verticalChangeTextBox.text] && [self validateDecimalInput: horizontalChangeTextBox.text])
    {
        [self performSegueWithIdentifier:@"nextPage" sender:sender];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid input" message:@"The form must include all valid input before continuing" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
}
@end
