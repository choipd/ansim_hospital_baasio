//
//  HospitalsTVC.m
//  StartUp Project
//
//  Created by Myungjin Choi on 13. 2. 2..
//  Copyright (c) 2013년 kth. All rights reserved.
//

#import "HospitalsTVC.h"
#import "AppDelegate.h"

@interface HospitalsTVC ()

@end

@implementation HospitalsTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refresh {
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self setupTableWithCollection:@"hospitals" withQuery:
        [NSString  stringWithFormat:@"location within 4000 of %f, %f",
        appDelegate.bestEffortAtLocation.coordinate.latitude, appDelegate.bestEffortAtLocation.coordinate.longitude]];
    [super refresh];
}
@end
