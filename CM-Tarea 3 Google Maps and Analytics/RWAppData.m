//
//  RWAppData.m
//  CM-Tarea 3 Google Maps and Analytics
//
//  Created by Aleyr on 7/11/15.
//  Copyright (c) 2015 CM. All rights reserved.
//

#import "RWAppData.h"

@implementation RWAppData

@synthesize maLocations;
@synthesize strPreviousController;
@synthesize listSelected;

static NSString* const SSMapLocations = @"map_locations";


- (void)encodeWithCoder:(NSCoder *)encoder
{
    //[super encodeWithCoder:encoder];
    
    NSData *mapLocationsData = [NSKeyedArchiver archivedDataWithRootObject:maLocations];
    [[NSUserDefaults standardUserDefaults] setObject:mapLocationsData forKey:SSMapLocations];
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [self init];
    if (self) {
        NSData *mapLocationsData = [[NSUserDefaults standardUserDefaults] objectForKey:SSMapLocations];
        self.maLocations = [NSKeyedUnarchiver unarchiveObjectWithData:mapLocationsData];
        
        // Initialize the array if null
        if (nil == self.maLocations) {
            self.maLocations = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

+ (instancetype)sharedMapLocations
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self loadInstance];
    });
    
    return sharedInstance;
}

+(NSString*)filePath
{
    static NSString* filePath = nil;
    if (!filePath) {
        filePath =
        [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
         stringByAppendingPathComponent:SSMapLocations];
    }
    return filePath;
}

+(instancetype)loadInstance
{
    NSData* decodedData = [NSData dataWithContentsOfFile: [RWAppData filePath]];
    if (decodedData) {
        RWAppData* appData = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
        return appData;
    }
    
    return [[RWAppData alloc] init];
}

-(void)save
{
    NSData* encodedData = [NSKeyedArchiver archivedDataWithRootObject: self];
    [encodedData writeToFile:[RWAppData filePath] atomically:YES];
}


@end
