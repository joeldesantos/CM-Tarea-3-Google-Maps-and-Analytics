//
//  MapLocation.h
//  CM-Tarea 3 Google Maps and Analytics
//
//  Created by Aleyr on 7/11/15.
//  Copyright (c) 2015 CM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapLocation : NSObject <NSCoding> {
    NSString *strName;
    NSString *strDescription;
}

@property (nonatomic, copy) NSString *strName;
@property (nonatomic, copy) NSString *strDescription;

@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;

@end
