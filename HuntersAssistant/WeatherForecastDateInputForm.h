//
//  WeatherForecastDateInputForm.h
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 2/17/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherRequest.h"

@interface WeatherForecastDateInputForm : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>{
    NSArray *daysArray;
}

@property (nonatomic, weak) IBOutlet UITextField *monthTextBox;

@property (nonatomic, weak) IBOutlet UITextField *dayTextBox;

@property (nonatomic, weak) IBOutlet UITextField *yearTextBox;

@property (nonatomic, strong) WeatherRequest *request;

@property (nonatomic, strong) IBOutlet UIPickerView *numberOfDays;


@property (nonatomic) NSString *month;
@property (nonatomic) NSString *day;
@property (nonatomic) NSString *year;
- (IBAction)getForecast:(id)sender;

@end
