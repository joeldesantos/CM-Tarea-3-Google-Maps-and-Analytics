//
//  ViewController.h
//  CM-Tarea 3 Google Maps and Analytics
//
//  Created by Aleyr on 7/10/15.
//  Copyright (c) 2015 CM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Google/Analytics.h>
#import "MapLocation.h"
@import GoogleMaps;

@interface Start : UIViewController<CLLocationManagerDelegate>

@property (strong, nonatomic)   CLLocationManager   *locationManager;
@property (strong, nonatomic)   CLLocation          *location;


@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

- (IBAction)btnListAction:(id)sender;
- (IBAction)btnAddAction:(id)sender;


- (void) setPosition:(float) lat withLongitude:(float) lon;
- (void) startLocalization;
- (void) stopLocalization;
- (void) createMarker:(MapLocation *)ml withView:(GMSMapView *)mv;
- (void) paintMap;

@end

