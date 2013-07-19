//
//  XMLFileFunctions.m
//  HuntersAssistantIPhone
//
//  Created by Jerran Simpson on 2/21/13.
//  Copyright (c) 2013 Jerran Simpson. All rights reserved.
//

#import "XMLFileFunctions.h"
#import "GunProfile.h"

@implementation XMLFileFunctions
NSMutableString* currentName;
NSString* currentElement;
GunProfile* currentProfile;
NSString* xmlString;
NSMutableArray* gunProfiles;
NSMutableArray* constants;

-(void) saveToFile:(NSString*)xmlString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"HuntersAssistant_GunProfiles.txt"];
    
    [xmlString writeToFile:filePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
}

-(void) saveToCalibrationFile:(NSString*) xmlString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"HuntersAssistant_Calibration.txt"];
    [xmlString writeToFile:filePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
}

-(NSString*) readStringFromFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"HuntersAssistant_GunProfiles.txt"];
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    return fileContents;
}

-(NSString*) readStringFromCalibrationFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"HuntersAssistant_Calibration.txt"];
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    return fileContents;
}

-(NSString*) createXMLStringFromGunProfiles:(NSArray*)gunProfiles
{
    NSString *xml = @"<?xml version='1.0' encoding='UTF-8' standalone='yes' ?><GunProfiles>";
    for(int i = 0; i < gunProfiles.count; i++)
    {
        GunProfile *profile = [gunProfiles objectAtIndex:i];
        xml = [xml stringByAppendingString:@"<GunProfile Name=\""];
        xml = [xml stringByAppendingString:profile.profileName];
        xml = [xml stringByAppendingString:@"\"><BallisticCoefficient>"];
        xml = [xml stringByAppendingString:[NSString stringWithFormat:@"%f", profile.ballisticCoefficient]];
        xml = [xml stringByAppendingString:@"</BallisticCoefficient><InitialVelocity>"];
        xml = [xml stringByAppendingString:[NSString stringWithFormat:@"%f", profile.initialVelocity]];
        xml = [xml stringByAppendingString:@"</InitialVelocity><ZeroRange>"];
        xml = [xml stringByAppendingString:[NSString stringWithFormat:@"%f", profile.zeroRange]];
        xml = [xml stringByAppendingString:@"</ZeroRange><SightHeight>"];
        xml = [xml stringByAppendingString:[NSString stringWithFormat:@"%f", profile.sightHeight]];
        xml = [xml stringByAppendingString:@"</SightHeight></GunProfile>"];
    }
    xml = [xml stringByAppendingString:@"</GunProfiles>"];
    return xml;
}

-(NSString*) createXMLStringFromBulletDropConstant:(double) bulletDropConstant windSpeedConstant:(double) windSpeedConstant windAngleConstant:(double)windAngleConstant
{
    NSString *xml = @"<?xml version='1.0' encoding='UTF-8' standalone='yes' ?><Calibration><WindSpeedConstant>";
    xml = [xml stringByAppendingString:[NSString stringWithFormat:@"%f", windSpeedConstant]];
    xml = [xml stringByAppendingString:@"</WindSpeedConstant>"];
    xml = [xml stringByAppendingString:@"<WindAngleConstant>"];
    xml = [xml stringByAppendingString:[NSString stringWithFormat:@"%f", windAngleConstant]];
    xml = [xml stringByAppendingString:@"</WindAngleConstant>"];
    xml = [xml stringByAppendingString:@"<BulletDropConstant>"];
    xml = [xml stringByAppendingString:[NSString stringWithFormat:@"%f", bulletDropConstant]];
    xml = [xml stringByAppendingString:@"</BulletDropConstant>"];
    xml = [xml stringByAppendingString:@"</Calibration>"];
    return xml;
}

- (void) parseXML
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [parser setDelegate:self];
    [parser parse];
}

-(NSMutableArray*) parseGunProfileXMLString:(NSString *)xml
{
    gunProfiles = [[NSMutableArray alloc] init];
    xmlString = xml;
    [self parseXML];
    return gunProfiles;
}
-(NSMutableArray*) parseCalibrationXMLString:(NSString*)xml
{
    constants = [[NSMutableArray alloc]init];
    xmlString = xml;
    [self parseXML];
    return constants;
}

-(void)parserDidStartDocument:(NSXMLParser*)parser
{
    currentElement = nil;
}

-(void)parser:(NSXMLParser*)parser didStartElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qualifiedName attributes:(NSDictionary*)attributeDict
{
    if([elementName isEqualToString:@"GunProfile"])
    {
        currentProfile = [GunProfile alloc];
        currentProfile.profileName = [attributeDict objectForKey:@"Name"];
    }
    currentElement = [elementName copy];
    currentName =[[NSMutableString alloc]init];
}
-(void) parser:(NSXMLParser*)parser didEndElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qName
{
    if([elementName isEqualToString:@"InitialVelocity"])
    {
        currentProfile.initialVelocity = [currentName doubleValue];
    }
    else if([elementName isEqualToString:@"ZeroRange"])
    {
        currentProfile.zeroRange = [currentName doubleValue];
    }
    else if([elementName isEqualToString:@"BallisticCoefficient"])
    {
        currentProfile.ballisticCoefficient = [currentName doubleValue];
    }
    else if([elementName isEqualToString:@"SightHeight"])
    {
        currentProfile.sightHeight = [currentName doubleValue];
        [gunProfiles addObject: currentProfile];
    }
    else if([elementName isEqualToString:@"WindSpeedConstant"])
    {
//        NSLog(currentName);
        [constants addObject:currentName];
    }
    else if([elementName isEqualToString:@"WindAngleConstant"])
    {
//        NSLog(currentName);
        [constants addObject:currentName];
    }
    else if([elementName isEqualToString:@"BulletDropConstant"])
    {
//        NSLog(currentName);
        [constants addObject:currentName];
    }
}


-(void)parser:(NSXMLParser*) parser foundCharacters:(NSString*)string
{
    [currentName appendString:string];
}
-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError
{
    NSLog(@"PARSING ERROR");
}


@end
