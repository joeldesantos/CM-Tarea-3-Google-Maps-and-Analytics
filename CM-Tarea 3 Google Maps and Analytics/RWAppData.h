//
//  RWAppData.h
//  CM-Tarea 3 Google Maps and Analytics
//
//  Created by Aleyr on 7/11/15.
//  Copyright (c) 2015 CM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWAppData : NSObject <NSCoding> {
    NSMutableArray *maLocations;
}

@property (nonatomic, retain)NSMutableArray *maLocations;

@property (assign, nonatomic)NSString *strPreviousController;
@property (assign, nonatomic)int listSelected;

+(instancetype)sharedMapLocations;
-(void)save;

@end
