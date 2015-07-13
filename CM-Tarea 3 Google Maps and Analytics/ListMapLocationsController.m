//
//  ListMapLocationsController.m
//  CM-Tarea 3 Google Maps and Analytics
//
//  Created by Aleyr on 7/11/15.
//  Copyright (c) 2015 CM. All rights reserved.
//

#import "ListMapLocationsController.h"
#import "RWAppData.h"
#import "AddMapLocationController.h"
#import "Start.h"
#import "MapLocationCell.h"
#import "MapLocation.h"

@interface ListMapLocationsController ()

@end

@implementation ListMapLocationsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tblLocations registerNib:[UINib nibWithNibName:@"MapLocationCell" bundle:nil] forCellReuseIdentifier:@"MapLocationCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [RWAppData sharedMapLocations].maLocations.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Initialize cells
    MapLocationCell *cell = (MapLocationCell *)[tableView dequeueReusableCellWithIdentifier:@"MapLocationCell"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"MapLocationCell" bundle:nil] forCellReuseIdentifier:@"MapLocationCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"MapLocationCell"];
    }
    
    //Fill cell with info from arrays
    MapLocation *mapLocation=[RWAppData sharedMapLocations].maLocations[indexPath.row];
    cell.lbTitle.text = mapLocation.strName;
    cell.lbDescription.text = mapLocation.strDescription;
    cell.lbLatitude.text = [NSString stringWithFormat:@"%.6lf, %.6lf", mapLocation.latitude, mapLocation.longitude];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [RWAppData sharedMapLocations].listSelected = (int)indexPath.row;
    
    //CharacterDetails *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CharacterDetails"];
    //[self presentViewController:viewController animated:YES completion:nil];
    Start *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Start"];
    [self presentViewController:vc animated:YES completion:^{
        //this code here will execute when modal is done being dismissed
        
        MapLocation *ml = [RWAppData sharedMapLocations].maLocations[[RWAppData sharedMapLocations].listSelected];

        // Change map position and re-paint
        [vc setPosition:ml.latitude withLongitude:ml.longitude];
        [vc paintMap];
        
        //Create a marker at the position
        [vc createMarker:ml withView:vc.mapView];
        
        //[vc startLocalization];

    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnMapAction:(id)sender {
    Start *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Start"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)btnAddAction:(id)sender {
    [RWAppData sharedMapLocations].strPreviousController = @"ListLocations";
    
    AddMapLocationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddLocation"];
    [self presentViewController:vc animated:YES completion:nil];

}
@end
