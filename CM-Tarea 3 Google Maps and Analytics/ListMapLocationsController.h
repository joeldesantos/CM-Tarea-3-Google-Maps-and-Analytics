//
//  ListMapLocationsController.h
//  CM-Tarea 3 Google Maps and Analytics
//
//  Created by Aleyr on 7/11/15.
//  Copyright (c) 2015 CM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListMapLocationsController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblLocations;

- (IBAction)btnMapAction:(id)sender;
- (IBAction)btnAddAction:(id)sender;

@end
