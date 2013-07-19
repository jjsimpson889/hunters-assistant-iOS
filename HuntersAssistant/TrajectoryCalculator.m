//
//  TrajectoryCalculator.m
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 3/4/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import "TrajectoryCalculator.h"
#import "XMLFileFunctions.h"

@implementation TrajectoryCalculator

@synthesize windAngleConstant;
@synthesize windSpeedConstant;
@synthesize bulletDropConstant;
XMLFileFunctions* xmlFunctions;


-(id)init {
    self = [super init];
    if(self != nil)
    {

        [self getCalibrationConstants];
    }
    return self;
}

-(void) getCalibrationConstants
{
    xmlFunctions = [XMLFileFunctions alloc];
    NSString *xmlString = [xmlFunctions readStringFromCalibrationFile];
    NSMutableArray* constants = [xmlFunctions parseCalibrationXMLString:xmlString];
    if([constants count] == 0)
    {
                windSpeedConstant = 18;
                windAngleConstant = 3;
                bulletDropConstant = 100;
    }
    else
    {
        windSpeedConstant = [[constants objectAtIndex:0] doubleValue];
        windAngleConstant = [[constants objectAtIndex:1] doubleValue];
        bulletDropConstant = [[constants objectAtIndex:2] doubleValue];
    }
}


-(double) calculateRemainingVelocityWithBallisticCoefficient:(double)ballisticCoefficient initialVelocity: (double)initialVelocity range:(double)range
{
    double remainingVelocity = 0;
    double temporaryVariable = sqrt(initialVelocity) - (0.00863*(range/ballisticCoefficient));
    remainingVelocity = temporaryVariable *temporaryVariable;
    return remainingVelocity;
}

-(double) calculateTemporaryVariableFWithBallisticCoefficient:(double)ballisticCoefficient initialVelocity:(double)initialVelocity range:(double)range
{
    double F = 0;
    double remainingVelocity = [self calculateRemainingVelocityWithBallisticCoefficient:ballisticCoefficient initialVelocity:initialVelocity range:range];
    F = 193*(1-(0.37*(initialVelocity-remainingVelocity))/initialVelocity);
    return F;
}

-(double) calculateTemporaryVariableKWithBallisticCoefficient:(double)ballisticCoefficient initialVelocity:(double) initialVelocity range:(double) range
{
    double K = 0;
    K = 2.878/(ballisticCoefficient*(sqrt(initialVelocity)));

    return K;
}

-(double) calculateTimeOfFlightWithBallisticCoefficient:(double)ballisticCoefficient initialVelocity:(double) initialVelocity range:(double)range
{
    double timeOfFlight = 0;
    double K = [self calculateTemporaryVariableKWithBallisticCoefficient:ballisticCoefficient initialVelocity:initialVelocity range:range];
    timeOfFlight = (3*range)/(initialVelocity*(1-(0.003*range*K)));
    return timeOfFlight;
}

-(double) calculateTotalDropFromDepartureWithBallisticCoefficient:(double)ballisticCoefficient initialVelocity:(double)initialVelocity range:(double) range
{
    double dropFromDeparture = 0;
    double F = [self calculateTemporaryVariableFWithBallisticCoefficient:ballisticCoefficient initialVelocity:initialVelocity range:range];
    double timeOfFlight = [self calculateTimeOfFlightWithBallisticCoefficient:ballisticCoefficient initialVelocity:initialVelocity range:range];
    dropFromDeparture = F*(timeOfFlight*timeOfFlight);

    return dropFromDeparture;
}

-(double) calculateElevationRequiredWithDropFromDeparture:(double) dropFromDeparture sightHeight:(double)sightHeight range:(double)range
{
    double elevationRequired = 0;
    elevationRequired = (100*(dropFromDeparture + sightHeight))/range;

    return elevationRequired;
}

-(double) calculateBulletDropWithBallisticCoefficient:(double) ballisticCoefficient initialVelocity:(double)initialVelocity range:(double)range zeroRange:(double)zeroRange sightHeight:(double)sightHeight
{
    double bulletDrop = 0;
    double dropFromDepartureAtTargetRange = [self calculateTotalDropFromDepartureWithBallisticCoefficient:ballisticCoefficient initialVelocity:initialVelocity range:range];
    double dropFromDepartureAtZeroRange = [self calculateTotalDropFromDepartureWithBallisticCoefficient:ballisticCoefficient initialVelocity:initialVelocity range:zeroRange];
    double elevationRequiredAtZeroRange = [self calculateElevationRequiredWithDropFromDeparture:dropFromDepartureAtZeroRange sightHeight:sightHeight range:zeroRange];
    double elevationRequiredAtTargetRange = [self calculateElevationRequiredWithDropFromDeparture:dropFromDepartureAtTargetRange sightHeight:sightHeight range:range];
    bulletDrop = ((elevationRequiredAtZeroRange - elevationRequiredAtTargetRange) * range)/bulletDropConstant;
    return bulletDrop;
}

-(double) calculateWindageWithBallisticCoefficient:(double)ballisticCoefficient windSpeed:(double)windSpeed range:(double)range initialVelocity:(double)initialVelocity windAngle:(double)windAngle
{
    double horizontalChange = 0;
    double radians = windAngle * M_PI/180;
    double TF = [self calculateTimeOfFlightWithBallisticCoefficient:ballisticCoefficient initialVelocity:initialVelocity range:range];
    horizontalChange = (windSpeedConstant*windSpeed)*(TF-((windAngleConstant*range)/initialVelocity))*sin(radians);
    return horizontalChange;
}

-(void) calibrateCalculatorWithBallisticCoefficient:(double)ballisticCoefficient realVerticalResult:(double)realVerticalResult realHorizontalResult:(double)realHorizontalResult secondRealHorizontalResult:(double)secondRealHorizontalResult windSpeed:(double)windSpeed secondWindSpeed:(double)secondWindSpeed windAngle:(double)windAngle secondWindAngle:(double)secondWindAngle timeOfFlight:(double)timeOfFlight secondTimeOfFlight:(double) secondTimeOfFlight initialVelocity:(double)initialVelocity secondInitialVelocity:(double)secondInitialVelocity range:(double)range secondRange:(double)secondRange zeroRange:(double)zeroRange sightHeight:(double)sightHeight
{
    double dropFromDepartureAtZeroRange = [self calculateTotalDropFromDepartureWithBallisticCoefficient:ballisticCoefficient initialVelocity:initialVelocity range:zeroRange];
    double dropFromDeparture = [self calculateTotalDropFromDepartureWithBallisticCoefficient:ballisticCoefficient initialVelocity:initialVelocity range:range];
    [self calibrateHorizontalChangeWithRealResult:realHorizontalResult secondRealResult:secondRealHorizontalResult windSpeed:windSpeed secondWindSpeed:secondWindSpeed windAngle:windAngle secondWindAngle:secondWindAngle timeOfFlight:timeOfFlight secondTimeOfFlight:secondTimeOfFlight initialVelocity:initialVelocity secondInitialVelocity:secondInitialVelocity range:range
                                      secondRange:secondRange];
    bulletDropConstant = [self calibrateVerticalChangeWithRealResult:realVerticalResult zeroRange: zeroRange range:range dropFromDeparture0:dropFromDepartureAtZeroRange dropFromDeparture1:dropFromDeparture sightHeight:sightHeight];
    NSString *xml = [xmlFunctions createXMLStringFromBulletDropConstant:bulletDropConstant windSpeedConstant:windSpeedConstant windAngleConstant:windAngleConstant];
    [xmlFunctions saveToCalibrationFile:xml];
}

-(void) calibrateHorizontalChangeWithRealResult:(double)realResult secondRealResult:(double)secondRealResult windSpeed:(double)windSpeed secondWindSpeed:(double)secondWindSpeed windAngle:(double)windAngle secondWindAngle:(double)secondWindAngle timeOfFlight:(double)timeOfFlight secondTimeOfFlight:(double)secondTimeOfFlight initialVelocity:(double)initialVelocity secondInitialVelocity:(double)secondInitialVelocity range:(double)range secondRange:(double)secondRange
{
    windSpeedConstant = [self calculateWindSpeedConstantWithRealResult:realResult secondRealResult:secondRealResult windSpeed:windSpeed secondWindSpeed:secondWindSpeed windAngle:windAngle secondWindAngle:secondWindAngle timeOfFlight:timeOfFlight secondTimeOfFlight:secondTimeOfFlight initialVelocity:initialVelocity secondInitialVelocity:secondInitialVelocity range:range secondRange:secondRange];
    windAngleConstant = [self calculateWindAngleConstantWithRealResult:realResult windSpeed:windSpeed windAngle:windAngle timeOfFlight:timeOfFlight initialVelocity:initialVelocity range:range windSpeedConstant:windSpeedConstant];
}

-(double) calibrateVerticalChangeWithRealResult:(double)realResult zeroRange:(double)zeroRange range:(double)range dropFromDeparture0:(double)dropFromDeparture0 dropFromDeparture1:(double)dropFromDeparture1 sightHeight:(double)sightHeight
{
    double constant = 0;
    double EL0 = [self calculateElevationRequiredWithDropFromDeparture:dropFromDeparture0 sightHeight:sightHeight range:zeroRange];
    double EL1 = [self calculateElevationRequiredWithDropFromDeparture:dropFromDeparture1 sightHeight:sightHeight range:range];
    constant = ((EL0-EL1)*range)/realResult;
    return constant;
}

-(double) calculateWindSpeedConstantWithRealResult:(double)realResult secondRealResult:(double)secondRealResult windSpeed:(double)windSpeed secondWindSpeed:(double)secondWindSpeed windAngle:(double) windAngle secondWindAngle:(double)secondWindAngle timeOfFlight:(double)TF secondTimeOfFlight:(double)secondTF initialVelocity:(double) initialVelocity secondInitialVelocity:(double)secondInitialVelocity range:(double)range secondRange:(double) secondRange
{
    double constant = 0;
    double radians = windAngle * M_PI/180;
    double radians2 = secondWindAngle *M_PI/180;
    constant = ((((secondRealResult/(secondWindSpeed*sin(radians2)))*secondInitialVelocity) - (((((realResult/(windSpeed*sin(radians)))*initialVelocity)/(range*-1))*(secondRange*-1))))*(range*-1))/((range*-1*secondTF*secondInitialVelocity)-(secondRange*-1*TF*initialVelocity));
    return constant;
}

-(double) calculateWindAngleConstantWithRealResult:(double)realResult windSpeed:(double)windSpeed windAngle:(double)windAngle timeOfFlight:(double)timeOfFlight initialVelocity:(double)initialVelocity range:(double)range windSpeedConstant:(double)windSpeedConstant
{
    double constant = 0;
    double radians = windAngle * M_PI/180;
    constant = ((((realResult/(windSpeed*sin(radians)))*initialVelocity)/windSpeedConstant) - (timeOfFlight*initialVelocity))/(range*-1);
    return constant;
}

@end
