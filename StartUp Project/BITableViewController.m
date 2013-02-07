//
//  BITableViewController.m
//  StartUp Project
//
//  Created by Myungjin Choi on 13. 2. 2..
//  Copyright (c) 2013년 kth. All rights reserved.
//

#import "BITableViewController.h"
#import <baas.io/Baas.h>

@interface BITableViewController () {
    NSString* _collection;
    NSString* _ql;
    NSMutableArray* _data;
}
-(void)setupTableWithCollection:(NSString*)collectionName withQuery:(NSString*)ql;

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
}

- (void) query
{
    BaasioQuery* q = [BaasioQuery queryWithCollection:@"rawdata"];
    [q queryInBackground:^(NSArray *objects) {
        NSLog(@"%@", [NSMutableArray arrayWithArray:objects]);
        _data = [NSMutableArray arrayWithArray:objects];
        [self stopLoading];
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
        [self stopLoading];
    }];
//    BaasioQuery* q = [BaasioQuery queryWithCollection:_collection];
//    
//    if (_ql) {
//        [q setWheres:_ql];
//    }
//    [q queryInBackground:^(NSArray *objects) {
//        NSLog(@"%@", [NSMutableArray arrayWithArray:objects]);
//        _data = [NSMutableArray arrayWithArray:objects];
//        [self.tableView reloadData];
//    } failureBlock:^(NSError *error) {
//        NSLog(@"%@", error.description);
//    }];
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
    return [_data count];
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"cell %d", indexPath.row];
//    
//    // Configure the cell...
//    
//    return cell;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"entityCell";
    
    UITableViewCell *entityCell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (entityCell == nil) {
        entityCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        entityCell.textLabel.text = [NSString stringWithFormat:@"%@", [[_data objectAtIndex:indexPath.row] objectForKey:@"title"]];
    }
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
