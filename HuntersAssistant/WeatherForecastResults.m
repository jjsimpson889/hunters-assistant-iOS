//
//  WeatherForecastResults.m
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 2/18/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import "WeatherForecastResults.h"

@interface WeatherForecastResults ()

@end

@implementation WeatherForecastResults

@synthesize dateLabel;
@synthesize weatherDescriptionLabel;
@synthesize weatherImageIcon;
@synthesize minimumTemperatureCelsiusLabel;
@synthesize minimumTemperatureFarenheitLabel;
@synthesize maximumTemperatureCelsiusLabel;
@synthesize maximumTemperatureFarenheitLabel;
@synthesize windSpeedKilometersPerHourLabel;
@synthesize windSpeedMilesPerHourLabel;
@synthesize forecast;
NSMutableData* responseData;
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
    dateLabel.text = forecast.date;
    weatherDescriptionLabel.text = [@"Weather Description: " stringByAppendingString:forecast.weatherDescription];
    minimumTemperatureCelsiusLabel.text = [forecast
.minimumTemperatureCelsius stringByAppendingString:@" C"];
    minimumTemperatureFarenheitLabel.text = [forecast.minimumTemperatureFarenheit stringByAppendingString:@" F"];
    maximumTemperatureCelsiusLabel.text = [forecast.maximumTemperatureCelsius stringByAppendingString:@" C"];
    maximumTemperatureFarenheitLabel.text = [forecast.maximumTemperatureFarenheit stringByAppendingString:@" F"];
    windSpeedKilometersPerHourLabel.text = [forecast.windSpeedKilometersPerHour stringByAppendingString:@" KmPH"];
    windSpeedMilesPerHourLabel.text = [forecast.windSpeedMilesPerHour stringByAppendingString:@" MPH"];
    forecast.imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:forecast.imageURL]];
    [weatherImageIcon setImage:[UIImage imageWithData:forecast.imageData]];
}

- (void) connection:(NSURLConnection *) connection didReceiveResonse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    [responseData appendData:data];
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection
{

}
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"something very bad happened");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
