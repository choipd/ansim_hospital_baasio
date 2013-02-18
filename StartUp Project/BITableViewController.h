//
//  BITableViewController.h
//  StartUp Project
//
//  Created by Myungjin Choi on 13. 2. 2..
//  Copyright (c) 2013년 kth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
@interface BITableViewController : PullRefreshTableViewController

-(id)initWithCollectionName:(NSString*) collectionName withQuery:(NSString*) ql;
-(void)setupTableWithCollection:(NSString*)collectionName withQuery:(NSString*)ql;

@end
