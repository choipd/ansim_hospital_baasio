//
//  HospitalsTVC.m
//  StartUp Project
//
//  Created by Myungjin Choi on 13. 2. 2..
//  Copyright (c) 2013년 kth. All rights reserved.
//

#import "HospitalsTVC.h"
#import "AppDelegate.h"

@interface HospitalsTVC () {
    AppDelegate* _appDelegate;
}
@end

@implementation HospitalsTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.title = @"Hospitals Nearby";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refresh {
    [self setupTableWithCollection:@"hospitals" withQuery:
        [NSString  stringWithFormat:@"location within 4000 of %f, %f",
        _appDelegate.bestEffortAtLocation.coordinate.latitude, _appDelegate.bestEffortAtLocation.coordinate.longitude]];
    [super refresh];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"entityCell";
    
    UITableViewCell *entityCell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (entityCell == nil) {
        entityCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellName];
    }
    entityCell.textLabel.text = [NSString stringWithFormat:@"%@",
                                 [[self.data objectAtIndex:indexPath.row] objectForKey:@"title"]];
    
    CLLocationDegrees lat = [[[[self.data objectAtIndex:indexPath.row] objectForKey:@"location"] objectForKey:@"latitude"] doubleValue];
    CLLocationDegrees lng = [[[[self.data objectAtIndex:indexPath.row] objectForKey:@"location"] objectForKey:@"longitude"] doubleValue];
    CLLocation* destination = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    CLLocationDistance dist = [_appDelegate.bestEffortAtLocation distanceFromLocation:destination];
    
    entityCell.detailTextLabel.text = [NSString stringWithFormat:@"%d m", (int)dist];
    
    return entityCell;
}

@end
