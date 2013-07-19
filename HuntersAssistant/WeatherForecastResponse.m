//
//  WeatherForecastResponse.m
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 2/18/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import "WeatherForecastResponse.h"
#import "DayForecast.h"

@implementation WeatherForecastResponse

@synthesize day1;
@synthesize day2;
@synthesize day3;
@synthesize day4;
@synthesize day5;
@synthesize count;


- (id)init
{
    self = [super init];
    if(self)
    {
        day1 = [DayForecast alloc];
        day2 = [DayForecast alloc];
        day3 = [DayForecast alloc];
        day4 = [DayForecast alloc];
        day5 = [DayForecast alloc];
        count = 0;
    }
    return self;
}

- (void) addDay:(DayForecast*)day
{
    if(count == 0)
    {
        day1 = day;
    }
    else if(count == 1)
    {
        day2 = day;
    }
    else if(count == 2)
    {
        day3 = day;
    }
    else if(count == 3)
    {
        day4 = day;
    }
    else if(count == 4)
    {
        day5 = day;
    }
    count++;
}

@end
