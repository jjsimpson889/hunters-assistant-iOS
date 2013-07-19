//
//  WeatherForecastDateInputForm.m
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 2/17/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import "WeatherForecastDateInputForm.h"
#import "WeatherForecastResultsTable.h"

@interface WeatherForecastDateInputForm()

@end

@implementation WeatherForecastDateInputForm
@synthesize numberOfDays;
@synthesize monthTextBox;
@synthesize dayTextBox;
@synthesize yearTextBox;
@synthesize request;
@synthesize month;
@synthesize day;
@synthesize year;


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


- (void)viewDidLoad
{
    [super viewDidLoad];
    daysArray = [[NSArray alloc] initWithObjects:@"2", @"3", @"4", @"5",nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSInteger row = [numberOfDays selectedRowInComponent:0];
    NSString *selectedValue = [daysArray objectAtIndex:row];
    [request setNumberOfDays:selectedValue];
    [request setMonth:monthTextBox.text];
    [request setDay:dayTextBox.text];
    [request setYear:yearTextBox.text];
    WeatherForecastResultsTable *destination = [segue destinationViewController];
    destination.request = request;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return [daysArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [daysArray objectAtIndex:row];
}

- (IBAction)getForecast:(id)sender {
    
    NSDate *currentDate = [NSDate date];
    
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:currentDate];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.year = [yearTextBox.text intValue];
//    dateComponents.year = [components year];
    dateComponents.month = [monthTextBox.text intValue];
    dateComponents.day = [dayTextBox.text intValue];
    NSDate *desiredDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    NSTimeInterval secondsBetween = [desiredDate timeIntervalSinceDate:currentDate];
    int daysInterval = secondsBetween /86400;
    
    if(daysInterval < 4)
    {
        [self performSegueWithIdentifier:@"getForecast" sender:sender];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid input" message:@"Forecasting a specific date must be within the next 4 days" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
}
@end
