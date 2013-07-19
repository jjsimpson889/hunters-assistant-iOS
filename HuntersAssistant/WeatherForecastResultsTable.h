//
//  WeatherForecastResultsTable.h
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 2/25/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherForecastResponse.h"
#import "WeatherRequest.h"

@interface WeatherForecastResultsTable : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *forecasts;
}
@property (strong, nonatomic) NSArray *forecasts;
@property (strong, nonatomic) WeatherForecastResponse *response;
@property (strong, nonatomic) WeatherRequest *request;

@end
