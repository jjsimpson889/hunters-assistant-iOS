//
//  WeatherForecastResults.h
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 2/18/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayForecast.h"

@interface WeatherForecastResults : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageIcon;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *minimumTemperatureFarenheitLabel;
@property (weak, nonatomic) IBOutlet UILabel *minimumTemperatureCelsiusLabel;
@property (weak, nonatomic) IBOutlet UILabel *maximumTemperatureFarenheitLabel;
@property (weak, nonatomic) IBOutlet UILabel *maximumTemperatureCelsiusLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedMilesPerHourLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedKilometersPerHourLabel;

@property (strong, nonatomic) DayForecast *forecast;
@end
