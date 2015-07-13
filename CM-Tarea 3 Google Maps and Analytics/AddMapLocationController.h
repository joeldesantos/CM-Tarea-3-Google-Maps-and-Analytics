//
//  AddMapLocationController.h
//  CM-Tarea 3 Google Maps and Analytics
//
//  Created by Aleyr on 7/11/15.
//  Copyright (c) 2015 CM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AddMapLocationController : UIViewController<CLLocationManagerDelegate>

@property (strong, nonatomic)   CLLocationManager   *locationManager;
@property (strong, nonatomic)   CLLocation          *location;

@property (strong, nonatomic) IBOutlet UITextField *tfName;
@property (strong, nonatomic) IBOutlet UITextField *tfDescription;
@property (strong, nonatomic) IBOutlet UITextField *tfLatitude;
@property (strong, nonatomic) IBOutlet UITextField *tfLongitude;

- (IBAction)btnCancelAction:(id)sender;
- (IBAction)btnGetLocationAction:(id)sender;
- (IBAction)btnSaveAction:(id)sender;

@end
