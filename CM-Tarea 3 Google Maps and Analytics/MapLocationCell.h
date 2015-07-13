//
//  MapLocationCell.h
//  CM-Tarea 3 Google Maps and Analytics
//
//  Created by Aleyr on 7/11/15.
//  Copyright (c) 2015 CM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapLocationCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbDescription;
@property (strong, nonatomic) IBOutlet UILabel *lbLatitude;

@end
