//
//  XMLFileFunctions.h
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 2/21/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLFileFunctions : NSObject


-(void) saveToFile:(NSString*)xmlString;
-(void) saveToCalibrationFile:(NSString*) xmlString;
-(NSString*) readStringFromFile;
-(NSString*) createXMLStringFromGunProfiles:(NSArray*)gunProfiles;
-(NSMutableArray*) parseGunProfileXMLString:(NSString*)xml;

-(NSMutableArray*) parseCalibrationXMLString:(NSString*)xml;
-(NSString*) createXMLStringFromBulletDropConstant:(double) bulletDropConstant windSpeedConstant:(double) windSpeedConstant windAngleConstant:(double)windAngleConstant;
-(NSString*) readStringFromCalibrationFile;

@end
