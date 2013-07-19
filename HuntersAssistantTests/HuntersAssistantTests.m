//
//  HuntersAssistantTests.m
//  HuntersAssistantTests
//
//  Created by Jerran Simpson on 2/10/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import "HuntersAssistantTests.h"
#import "TrajectoryCalculator.h"

@implementation HuntersAssistantTests

TrajectoryCalculator *calculator;

- (void)setUp
{
    [super setUp];
    
}

-(void) testCalculateBulletDrop
{
    calculator = [TrajectoryCalculator alloc];
    double bulletDrop = [calculator calculateBulletDropWithBallisticCoefficient:0.314 initialVelocity:2820 range:200 zeroRange:200 sightHeight:1.5]
    STAssertTrue(bulletDRop >= 0 && bulletDrop <=1);
    
    bulletDrop = [calculator calculateBulletDropWithBallisticCoefficient:0.314 initialVelocity:2820 range:600 zeroRange:200 sightHeight:1.5];
    STAssertTrue(bulletDRop >= -101 && bulletDrop <=-99);
    
    bulletDrop = [calculator calculateBulletDropWithBallisticCoefficient:0.314 initialVelocity:2900    range:400 zeroRange:100 sightHeight:2.0];
    STAssertTrue(bulletDRop >= -31 && bulletDrop <=-30);
}

-(void) testHorizontalChange
{
    calculator = [TrajectoryCalculator alloc];
    double horizontalChange = [calculator calculateWindageWithBallisticCoefficient:0.314 windSpeed:50 range:600 initialVelocity:2820 windAngle:90];
    STAssertTrue(horizontalChange <= 259 && horizontalChange >= 258);
    
    horizontalChange = [calculator calculateWindageWithBallisticCoefficient:0.314 windSpeed:50 range:200 initialVelocity:2820 windAngle:90];
    STAssertTrue(horizontalChange <= 23 && horizontalChange >= 22);
}

-(void) testCalibrateVerticalChange
{
    calculator = [TrajectoryCalculator alloc];
    double dropFromDeparture0 = [calculator calculateTotalDropFromDepartureWithBallisticCoefficient:0.314 initialVelocity:2820 range:200];
    double dropFromDeparture1 = [calculator calculateTotalDropFromDepartureWithBallisticCoefficient:0.314 initialVelocity:2820 range:600];
    double verticalCalibrationConstant = [calculator calibrateVerticalChangeWithRealResult:-101 zeroRange:200 range:600 dropFromDeparture0:dropFromDeparture0 dropFromDeparture1:dropFromDeparture1 sightHeight:1.5];
    STAssertTrue(verticalCalibrationConstant >= 99.1 && verticalCalibrationConstant <= 99.2);
}

-(void) testCalculateWindSpeedConstant
{
    calculator = [TrajectoryCalculator alloc];
    double secondTF = [calculator calculateTimeOfFlightWithBallisticCoefficient:0.314 initialVelocity:2820 range:600];
    double TF = [calculator calculateTimeOfFlightWithBallisticCoefficient:0.314 initialVelocity:2820 range:200];
    double windSpeedConstant = [calculator calculateWindSpeedConstantWithRealResult:22 secondRealResult:250 windSpeed:50 secondWindSpeed:50 windAngle:90 secondWindAngle:90 timeOfFlight:TF secondTimeOfFlight:secondTF initialVelocity:2820 secondInitialVelocity:2820 range:200 secondRange:600];
    STAssertTrue(windSpeedConstant >= 19.2 && windSpeedConstant <= 19.3);
}

-(void) testCalculateWindAngleConstant
{
    calculator = [TrajectoryCalculator alloc];
    double secondTF = [calculator calculateTimeOfFlightWithBallisticCoefficient:0.314 initialVelocity:2820 range:600];
    double TF = [calculator calculateTimeOfFlightWithBallisticCoefficient:0.314 initialVelocity:2820 range:200];
    double windSpeedConstant = [calculator calculateWindSpeedConstantWithRealResult:22 secondRealResult:250 windSpeed:50 secondWindSpeed:50 windAngle:90 secondWindAngle:90 timeOfFlight:TF secondTimeOfFlight:secondTF initialVelocity:2820 secondInitialVelocity:2820 range:200 secondRange:600];
    double windAngleConstant = [calculator calculateWindAngleConstantWithRealResult:22.03 windSpeed:50 windAngle:90 timeOfFlight:TF initialVelocity:2820 range:200 windSpeedConstant:windSpeedConstant];
    STAssertTrue(windAngleConstant <= 3 && windAngleConstant >= 2.9);
}

- (void)tearDown
{
    [super tearDown];
}

@end
