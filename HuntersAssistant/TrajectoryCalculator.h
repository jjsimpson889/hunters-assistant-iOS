//
//  TrajectoryCalculator.h
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 3/4/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrajectoryCalculator : NSObject
@property (atomic) double windSpeedConstant;
@property (atomic) double windAngleConstant;
@property (atomic) double bulletDropConstant;

-(double) calculateRemainingVelocityWithBallisticCoefficient:(double)ballisticCoefficient initialVelocity: (double)initialVelocity range:(double)range;

-(double) calculateTemporaryVariableFWithBallisticCoefficient:(double)ballisticCoefficient initialVelocity:(double)initialVelocity range:(double)range;

-(double) calculateTemporaryVariableKWithBallisticCoefficient:(double)ballisticCoefficient initialVelocity:(double) initialVelocity range:(double) range;

-(double) calculateTimeOfFlightWithBallisticCoefficient:(double)ballisticCoefficient initialVelocity:(double) initialVelocity range:(double)range;

-(double) calculateTotalDropFromDepartureWithBallisticCoefficient:(double)ballisticCoefficient initialVelocity:(double)initialVelocity range:(double) range;

-(double) calculateElevationRequiredWithDropFromDeparture:(double) dropFromDeparture sightHeight:(double)sightHeight range:(double)range;

-(double) calculateBulletDropWithBallisticCoefficient:(double) ballisticCoefficient initialVelocity:(double)initialVelocity range:(double)range zeroRange:(double)zeroRange sightHeight:(double)sightHeight;

-(double) calculateWindageWithBallisticCoefficient:(double)ballisticCoefficient windSpeed:(double)windSpeed range:(double)range initialVelocity:(double)initialVelocity windAngle:(double)windAngle;

-(void) calibrateCalculatorWithBallisticCoefficient:(double)ballisticCoefficient realVerticalResult:(double)realVerticalResult realHorizontalResult:(double)realHorizontalResult secondRealHorizontalResult:(double)secondRealHorizontalResult windSpeed:(double)windSpeed secondWindSpeed:(double)secondWindSpeed windAngle:(double)windAngle secondWindAngle:(double)secondWindAngle timeOfFlight:(double)timeOfFlight secondTimeOfFlight:(double) secondTimeOfFlight initialVelocity:(double)initialVelocity secondInitialVelocity:(double)secondInitialVelocity range:(double)range secondRange:(double)secondRange zeroRange:(double)zeroRange sightHeight:(double)sightHeight;

-(void) calibrateHorizontalChangeWithRealResult:(double)realResult secondRealResult:(double)secondRealResult windSpeed:(double)windSpeed secondWindSpeed:(double)secondWindSpeed windAngle:(double)windAngle secondWindAngle:(double)secondWindAngle timeOfFlight:(double)timeOfFlight secondTimeOfFlight:(double)secondTimeOfFlight initialVelocity:(double)initialVelocity secondInitialVelocity:(double)secondInitialVelocity range:(double)range secondRange:(double)secondRange;

-(double) calibrateVerticalChangeWithRealResult:(double)realResult zeroRange:(double)zeroRange range:(double)range dropFromDeparture0:(double)dropFromDeparture0 dropFromDeparture1:(double)dropFromDeparture1 sightHeight:(double)sightHeight;

-(double) calculateWindSpeedConstantWithRealResult:(double)realResult secondRealResult:(double)secondRealResult windSpeed:(double)windSpeed secondWindSpeed:(double)secondWindSpeed windAngle:(double) windAngle secondWindAngle:(double)secondWindAngle timeOfFlight:(double)TF secondTimeOfFlight:(double)secondTF initialVelocity:(double) initialVelocity secondInitialVelocity:(double)secondInitialVelocity range:(double)range secondRange:(double) secondRange;

-(double) calculateWindAngleConstantWithRealResult:(double)realResult windSpeed:(double)windSpeed windAngle:(double)windAngle timeOfFlight:(double)timeOfFlight initialVelocity:(double)initialVelocity range:(double)range windSpeedConstant:(double)windSpeedConstant;

@end
