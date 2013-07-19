//
//  GunProfileManager.m
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 2/21/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import "GunProfileManager.h"
#import "XMLFileFunctions.h"
#import "AddEditGunProfileForm.h"
#import "GunProfile.h"

@interface GunProfileManager ()

@end

@implementation GunProfileManager
@synthesize gunProfiles;
@synthesize gunProfilePicker;
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

- (IBAction)deleteProfileButton:(id)sender {
    XMLFileFunctions *xmlFunctions = [XMLFileFunctions alloc];
    NSInteger row = [gunProfilePicker selectedRowInComponent:0];
    GunProfile *selectedValue = [gunProfiles objectAtIndex:row];
    [gunProfiles removeObject:selectedValue];
    NSString *xmlString = [xmlFunctions createXMLStringFromGunProfiles:gunProfiles];
    [xmlFunctions saveToFile:xmlString];
    [gunProfilePicker reloadAllComponents];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString: @"editProfile"])
    {
        NSInteger row = [gunProfilePicker selectedRowInComponent:0];
        GunProfile *selectedValue = [gunProfiles objectAtIndex:row];
        AddEditGunProfileForm *destination = [segue destinationViewController];
        destination.currentProfile = selectedValue;
    }
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
