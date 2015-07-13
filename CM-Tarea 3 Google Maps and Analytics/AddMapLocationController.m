//
//  AddMapLocationController.m
//  CM-Tarea 3 Google Maps and Analytics
//
//  Created by Aleyr on 7/11/15.
//  Copyright (c) 2015 CM. All rights reserved.
//

#import "AddMapLocationController.h"
#import "RWAppData.h"
#import "Start.h"
#import "ListMapLocationsController.h"
#import "MapLocation.h"
@import GoogleMaps;


@interface AddMapLocationController ()

@end

@implementation AddMapLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Localization
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 500; // meters
    
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyBest;
    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.tfName.text = @"";
    self.tfDescription.text = @"";
    self.tfLatitude.text = @"";
    self.tfLatitude.text= @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.locationManager stopUpdatingLocation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnCancelAction:(id)sender {
    if ([@"Start" isEqualToString:[RWAppData sharedMapLocations].strPreviousController]) {
        Start *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Start"];
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        ListMapLocationsController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ListLocations"];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (IBAction)btnGetLocationAction:(id)sender {
    NSLog(@"Get Location button pressed");
    
    //Location
    if (nil != self.locationManager){
        NSLog(@"Latitude: %lf, Longitude: %lf", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
        self.tfLatitude.text = [NSString stringWithFormat:@"%lf", self.locationManager.location.coordinate.latitude];
        self.tfLongitude.text = [NSString stringWithFormat:@"%lf", self.locationManager.location.coordinate.longitude];
    } else {
        NSLog(@"no locationManager is present!!!!");
    }
}

- (IBAction)btnSaveAction:(id)sender {
    MapLocation *ml = [[MapLocation alloc] init];
    ml.strName = self.tfName.text;
    ml.strDescription = self.tfDescription.text;
    ml.latitude = [self.tfLatitude.text doubleValue];
    ml.longitude = [self.tfLongitude.text doubleValue];
    
    // Initialize the array if null
    if (nil == [RWAppData sharedMapLocations].maLocations) {
        [RWAppData sharedMapLocations].maLocations = [[NSMutableArray alloc] init];
    }
    
    [[RWAppData sharedMapLocations].maLocations addObject:ml];
    
    if ([@"Start" isEqualToString:[RWAppData sharedMapLocations].strPreviousController]) {
        Start *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Start"];
        [self presentViewController:vc animated:YES completion:^{
            //this code here will execute when modal is done being dismissed
            
            MapLocation *ml = [RWAppData sharedMapLocations].maLocations[[RWAppData sharedMapLocations].maLocations.count - 1];
            
            // Change map position and re-paint
            [vc setPosition:ml.latitude withLongitude:ml.longitude];
            [vc paintMap];
            
            //Create a marker at the position
            [vc createMarker:ml withView:vc.mapView];
        }];
    } else {
        ListMapLocationsController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ListLocations"];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

/**********************************************************************************************/
#pragma mark - Localization
/**********************************************************************************************/
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
        
        //self.tfLatitude.text = [NSString stringWithFormat:@"%lf", self.locationManager.location.coordinate.longitude];
        //self.tfLongitude.text = [NSString stringWithFormat:@"%lf", self.locationManager.location.coordinate.longitude];

        
        //mlatitude = self.locationManager.location.coordinate.latitude;
        //mlongitude = self.locationManager.location.coordinate.longitude;
        NSLog(@"mlatitude = %f", self.locationManager.location.coordinate.latitude);
        NSLog(@"mlongitude = %f", self.locationManager.location.coordinate.longitude);
    }];
    
}

@end
