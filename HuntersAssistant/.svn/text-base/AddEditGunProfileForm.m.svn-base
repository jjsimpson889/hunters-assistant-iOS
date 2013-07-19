//
//  AddEditGunProfileForm.m
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 2/21/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import "AddEditGunProfileForm.h"
#import "GunProfile.h"
#import "XMLFileFunctions.h"
#import "GunProfileManager.h"

@interface AddEditGunProfileForm ()

@end

@implementation AddEditGunProfileForm

@synthesize profileNameTextBox;
@synthesize ballisticCoefficientTextBox;
@synthesize initialVelocityTextBox;
@synthesize zeroRangeTextBox;
@synthesize sightHeightTextBox;
@synthesize gunProfiles;
@synthesize currentProfile;
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
    if(currentProfile != nil)
    {
        profileNameTextBox.text = currentProfile.profileName;
        ballisticCoefficientTextBox.text = [NSString stringWithFormat:@"%f",currentProfile.ballisticCoefficient];
        initialVelocityTextBox.text = [NSString stringWithFormat:@"%f",currentProfile.initialVelocity];
        zeroRangeTextBox.text = [NSString stringWithFormat:@"%f",currentProfile.zeroRange];
        sightHeightTextBox.text = [NSString stringWithFormat:@"%f",currentProfile.sightHeight];
    }
    xmlFunctions = [XMLFileFunctions alloc];
    NSString *xmlString = [xmlFunctions readStringFromFile];
    gunProfiles = [xmlFunctions parseGunProfileXMLString:xmlString];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(currentProfile == nil)
    {
        GunProfile *profile = [self createNewGunProfile];
        for(int i = 0; i < gunProfiles.count; i++)
        {
            GunProfile *p = [gunProfiles objectAtIndex:i];
            if([p.profileName isEqualToString:profile.profileName])
            {
                [gunProfiles removeObjectAtIndex:i];
            }
        }
        [gunProfiles addObject:profile];
    }
    else
    {
        [gunProfiles removeObject:currentProfile];
        currentProfile.profileName = profileNameTextBox.text;
        currentProfile.initialVelocity = [initialVelocityTextBox.text doubleValue];
        currentProfile.ballisticCoefficient = [ballisticCoefficientTextBox.text doubleValue];
        currentProfile.zeroRange = [zeroRangeTextBox.text doubleValue];
        currentProfile.sightHeight = [sightHeightTextBox.text doubleValue];
        [gunProfiles addObject: currentProfile];
    }
    NSString *xmlString = [xmlFunctions createXMLStringFromGunProfiles:gunProfiles];
    [xmlFunctions saveToFile:xmlString];
}

-(GunProfile*) createNewGunProfile
{
    GunProfile *profile = [GunProfile alloc];
    profile.profileName = profileNameTextBox.text;
    profile.ballisticCoefficient = [ballisticCoefficientTextBox.text doubleValue];
    profile.initialVelocity = [initialVelocityTextBox.text doubleValue];
    profile.zeroRange = [zeroRangeTextBox.text doubleValue];
    profile.sightHeight = [sightHeightTextBox.text doubleValue];
    return profile;
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

-(bool)validateTextInput: (NSString *) input
{
    bool isValid = false;
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([a-zA-Z_0-9])+"
                                                                           options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:input options:0 range:NSMakeRange(0, [input length])];
    isValid = numberOfMatches == 1;
    
    return isValid;
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

- (IBAction)saveProfile:(id)sender {
    if([self validateTextInput:profileNameTextBox.text] && [self validateDecimalInput:ballisticCoefficientTextBox.text] && [self validateDecimalInput:initialVelocityTextBox.text] && [self validateDecimalInput:zeroRangeTextBox.text] && [self validateDecimalInput:sightHeightTextBox.text])
    {
        [self performSegueWithIdentifier:@"saveProfile" sender:sender];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid input" message:@"The form must include all valid input before continuing" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
}
@end
