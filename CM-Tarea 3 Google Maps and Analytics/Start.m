//
//  ViewController.m
//  CM-Tarea 3 Google Maps and Analytics
//
//  Created by Aleyr on 7/10/15.
//  Copyright (c) 2015 CM. All rights reserved.
//

#import "Start.h"
#import "RWAppData.h"
#import "ListMapLocationsController.h"
#import "AddMapLocationController.h"
#import "MapLocation.h"
@import CoreLocation;


#define         nLocalizing     0
#define         nLocalized      1

//Localization
float                   mlatitude;
float                   mlongitude;
static int              iLocalizeState = nLocalized;


@interface Start ()

@end

@implementation Start {
    GMSMarker           *markerLocation;
    GMSCameraPosition   *camera;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Location
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyBest;

    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    if ([RWAppData sharedMapLocations].listSelected) {
        mlatitude = [(MapLocation *)[RWAppData sharedMapLocations].maLocations[[RWAppData sharedMapLocations].listSelected] latitude];
        mlongitude = [(MapLocation *)[RWAppData sharedMapLocations].maLocations[[RWAppData sharedMapLocations].listSelected] longitude];
    } else {
        // UAG location by default
        mlatitude = 20.703575;
        mlongitude = -103.417559;
    }
    [self paintMap];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"CM-Tarea 3:Start"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.locationManager stopUpdatingLocation];
}

/**********************************************************************************************/
#pragma mark - Maps methods
/**********************************************************************************************/

- (void) setPosition:(float) lat withLongitude:(float) lon {
    mlatitude = lat;
    mlongitude = lon;
}

- (void) startLocalization {
    iLocalizeState = nLocalizing;
}

- (void) stopLocalization {
    iLocalizeState = nLocalized;
}

- (void) createMarker:(MapLocation *)ml withView:(GMSMapView *)mv {
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(ml.latitude, ml.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = ml.strName;
    marker.snippet = ml.strDescription;
    marker.map = mv;
}


- (void) paintMap {
    [self.mapView removeFromSuperview];
    camera                      = [GMSCameraPosition cameraWithLatitude:mlatitude longitude:mlongitude zoom:16];
    self.mapView                     = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.frame               = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    self.mapView.myLocationEnabled   = YES;
    
    [self.view addSubview:self.mapView];
}


- (void) paintMarker {
    GMSMarker *marker       = [[GMSMarker alloc] init];
    marker.position         = camera.target;
    marker.title            = @"UAG";
    marker.snippet          = @"Clase de Maestría";
    marker.appearAnimation  = kGMSMarkerAnimationPop;
    marker.map = self.mapView;
    
    /*
    CLLocationCoordinate2D position;
    NSLog(@"maPlacesTitle.count %d", (int)maPlacesTitle.count);
    for (int i = 0; i<maPlacesTitle.count; i++)
    {
        CGFloat lat                     = (CGFloat)[maPlacesLat[i] floatValue];
        CGFloat lng                     = (CGFloat)[maPlacesLng[i] floatValue];
        NSLog(@"Marker lat %f, long %f", lat, lng);
        position                        = CLLocationCoordinate2DMake(lat, lng);
        markerLocation                  = [GMSMarker markerWithPosition:position];
        markerLocation.icon             = [GMSMarker markerImageWithColor:[UIColor greenColor]];
        markerLocation.title            = maPlacesTitle[i];
        markerLocation.snippet          = maPlacesSnippet[i];
        markerLocation.appearAnimation  = kGMSMarkerAnimationPop;
        markerLocation.map              = mapView;
    }
     */
}

/**********************************************************************************************/
#pragma mark - Localization
/**********************************************************************************************/
/*
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    NSLog(@"didUpdateLocation!");
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks) {
            NSString *addressName = [placemark name];
            NSString *city = [placemark locality];
            NSString *administrativeArea = [placemark administrativeArea];
            NSString *country  = [placemark country];
            NSString *countryCode = [placemark ISOcountryCode];
            NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
        }
        
        //mlatitude = self.locationManager.location.coordinate.latitude;
        //mlongitude = self.locationManager.location.coordinate.longitude;
        //NSLog(@"mlatitude = %f", mlatitude);
        //NSLog(@"mlongitude = %f", mlongitude);
        if (iLocalizeState == nLocalizing) {
            [self paintMap];
            [self paintMarker];
            iLocalizeState = nLocalized;
        }
    }];
    
}
*/

- (IBAction)btnListAction:(id)sender {
    ListMapLocationsController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ListLocations"];
    [self presentViewController:vc animated:YES completion:nil];

}

- (IBAction)btnAddAction:(id)sender {
    [RWAppData sharedMapLocations].strPreviousController = @"Start";
    
    AddMapLocationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddLocation"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
