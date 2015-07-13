//
//  MapLocation.m
//  CM-Tarea 3 Google Maps and Analytics
//
//  Created by Aleyr on 7/11/15.
//  Copyright (c) 2015 CM. All rights reserved.
//

#import "MapLocation.h"

@implementation MapLocation

@synthesize strName;
@synthesize strDescription;
@synthesize latitude;
@synthesize longitude;

static NSString* const SSMapLocationDataName = @"name";
static NSString* const SSMapLocationDataDescription = @"description";
static NSString* const SSMapLocationDataLatitude = @"latitude";
static NSString* const SSMapLocationDataLongitude = @"longitude";


- (void)encodeWithCoder:(NSCoder *)encoder
{
    //[super encodeWithCoder:encoder];
    
    [encoder encodeObject:self.strName forKey: SSMapLocationDataName];
    [encoder encodeObject:self.strDescription forKey: SSMapLocationDataDescription];
    [encoder encodeDouble:self.latitude forKey: SSMapLocationDataLatitude];
    [encoder encodeDouble:self.longitude forKey: SSMapLocationDataLongitude];
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    //self = [super initWithCoder:decoder];
    self = [super init];
    if (self) {
        self.strName = [decoder decodeObjectForKey:SSMapLocationDataName];
        self.strDescription = [decoder decodeObjectForKey:SSMapLocationDataDescription];
        self.latitude = [decoder decodeDoubleForKey:SSMapLocationDataLatitude];
        self.longitude = [decoder decodeDoubleForKey:SSMapLocationDataLongitude];
    }
    return self;
}

@end
