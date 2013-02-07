//
//  AppDelegate.h
//  StartUp Project
//
//  Created by cetauri on 12. 10. 30..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class BITableViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) BITableViewController *tvc;

@end
