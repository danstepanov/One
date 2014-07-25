//
//  AppDelegate.h
//  One
//
//  Created by Micah Benn on 7/17/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <SimpleAuth/SimpleAuth.h>
#import <FacebookSDK/FacebookSDK.h>

#import "OneTabBarItem.h"
#import "OneTabBarController.h"
#import "OneSocialPagingViewer.h"
#import "TimelineViewController.h"
#import "ActivityViewController.h"
#import "MessagesViewController.h"
#import "ProfileViewController.h"
#import "SearchViewController.h"
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
