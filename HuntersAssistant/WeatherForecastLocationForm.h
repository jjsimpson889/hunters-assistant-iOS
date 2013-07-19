//
//  WeatherForecastLocationForm.h
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 2/11/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WeatherForecastLocationForm : UIViewController <UITextFieldDelegate, CLLocationManagerDelegate>
{
    CLLocationManager* locationManager;
    id delegate;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) id delegate;

@property (nonatomic, weak) IBOutlet UITextField *zipCodeTextBox;

@property (nonatomic, weak) IBOutlet UITextField *latitudeTextBox;

@property (nonatomic, weak) IBOutlet UITextField *longitudeTextBox;

@property (nonatomic, weak) IBOutlet UITextField *cityTextBox;

@property (nonatomic, weak) IBOutlet UITextField *countryTextBox;
- (IBAction)getLocation:(id)sender;

-(void)locationUpdate:(CLLocation*)location;
-(void)locationError:(NSError*)error;

@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (weak, nonatomic) IBOutlet UIButton *getLocation;

@end
