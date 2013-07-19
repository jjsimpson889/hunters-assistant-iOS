//
//  WeatherForecastLocationForm.m
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 2/11/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import "WeatherForecastLocationForm.h"
#import <CoreLocation/CoreLocation.h>

@interface WeatherForecastLocationForm ()

@end
#import "WeatherRequest.h"
#import "WeatherForecastDateInputForm.h"

@implementation WeatherForecastLocationForm

@synthesize zipCodeTextBox;
@synthesize latitudeTextBox;
@synthesize longitudeTextBox;
@synthesize cityTextBox;
@synthesize countryTextBox;
@synthesize locationManager;

@synthesize zipCode;
@synthesize latitude;
@synthesize longitude;
@synthesize city;
@synthesize country;
WeatherRequest *request;

-(id)init {
    self = [super init];
    if(self != nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

- (IBAction)validateAllInput:(id)sender {
    
    request = [[WeatherRequest alloc] init];
    
    if([self validateZipcodeInput:zipCodeTextBox.text])
    {
        [request setZipCode:zipCodeTextBox.text];
        [self performSegueWithIdentifier:@"submitLocation" sender:sender];
    }
    else if(([self validateDecimalInput:latitudeTextBox.text] &&
        [self validateDecimalInput:longitudeTextBox.text]))
    {
        [request setLatitude:latitudeTextBox.text];
        [request setLongitude:longitudeTextBox.text];
        [self performSegueWithIdentifier:@"submitLocation" sender:sender];
    }
    else if([self validateTextInput:cityTextBox.text] && [self validateTextInput:countryTextBox.text])
    {
        [request setCity:cityTextBox.text];
        [request setCountry:countryTextBox.text];
        [self performSegueWithIdentifier:@"submitLocation" sender:sender];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid input" message:@"The form must include all valid input before continuing" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction) getLocation:(id)sender
{
    if([CLLocationManager locationServicesEnabled])
    {
        locationManager = [[CLLocationManager alloc] init];
        CLLocationCoordinate2D *currentLocation;
        currentLocation = (__bridge CLLocationCoordinate2D *)(locationManager.location);
        CLLocationCoordinate2D *oldLocation = currentLocation;
        [locationManager startUpdatingLocation];
        currentLocation = (__bridge CLLocationCoordinate2D *)(locationManager.location);
        CLLocationCoordinate2D *newLocation = currentLocation;
        [locationManager stopUpdatingLocation];
        [self locationManager:locationManager didUpdateToLocation:(__bridge CLLocation *)(newLocation) fromLocation:(__bridge CLLocation *)(oldLocation)];
    }
}

-(void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error{

    [self.delegate locationError:error];
}

-(void)locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self.delegate locationUpdate:newLocation];
    double lat = newLocation.coordinate.latitude;
    double lon = newLocation.coordinate.longitude;
    NSString *latString = [NSString stringWithFormat:@"%f", lat];
    NSString *lonString = [NSString stringWithFormat:@"%f", lon];
    latitudeTextBox.text = latString;
    longitudeTextBox.text = lonString;
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


-(bool)validateZipcodeInput:(NSString*) input
{
    bool isValid = false;
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(^[ABCEGHJKLMNPRSTVXY]\\d[ABCEGHJKLMNPRSTVWXYZ]()?\\d[ABCEGHJKLMNPRSTVWXYZ]\\d$)|(^\\d{5}(-\\d{4})?$)"
                                                                           options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:input options:0 range:NSMakeRange(0, [input length])];
    isValid = numberOfMatches == 1;
    
    return isValid;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WeatherForecastDateInputForm *destination = [segue destinationViewController];
    destination.request = request;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	latitudeTextBox.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    longitudeTextBox.keyboardType = UIKeyboardTypeNumbersAndPunctuation;}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
