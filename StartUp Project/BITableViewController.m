//
//  BITableViewController.m
//  StartUp Project
//
//  Created by Myungjin Choi on 13. 2. 2..
//  Copyright (c) 2013년 kth. All rights reserved.
//

#import "BITableViewController.h"
#import <baas.io/Baas.h>
#import "BIDetailViewController.h"

@interface BITableViewController () {
    NSString* _collection;
    NSString* _ql;
}

@end

@implementation BITableViewController


- (id) initWithCollectionName:(NSString*) collectionName withQuery:(NSString*) ql
{
    [self setupTableWithCollection:collectionName withQuery:ql];
    self = [super init];
    if (self) {
        // custom initialization
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setupTableWithCollection:(NSString*)collectionName withQuery:(NSString*)ql
{
    _collection = collectionName;
    _ql = ql;
    NSLog(@"[query]: %@",_ql);
}

- (void) query
{
    if (_collection == nil) {
        [NSException raise:@"Collection is nil" format:@"Collection is nil"];
    }
    
    BaasioQuery* q = [BaasioQuery queryWithCollection:_collection];
    [q setLimit:100];

    if (_ql) {
        [q setWheres:_ql];
    }
    
    [q queryInBackground:^(NSArray *objects) {
        NSLog(@"%@", [NSMutableArray arrayWithArray:objects]);
        self.data = [NSMutableArray arrayWithArray:objects];
        [self stopLoading];
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
        [self stopLoading];
    }];
}

- (void) refresh
{
    [self query];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"entityCell";
    
    UITableViewCell *entityCell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (entityCell == nil) {
        entityCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
//    entityCell.textLabel.text = [NSString stringWithFormat:@"%@",
//                                 [[self.data objectAtIndex:indexPath.row] objectForKey:@"title"]];
    return entityCell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     BIDetailViewController *detailViewController = [[BIDetailViewController alloc] init];
     [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
