//
//  AppDelegate.m
//  One
//
//  Created by Daniel Stepanov on 7/15/14.
//  Copyright (c) 2014 One. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <SimpleAuth/SimpleAuth.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    sleep(1); //Pause Launch Image for X seconds
    // Override point for customization after application launch.
    [Parse setApplicationId:@"QUCJSQNfkxKOFyoLf39E0p7pAKmayU9HiiGEfdRU"
                  clientKey:@"gUV6R2z7S41gGsXpqCE3aeDjJ9kCpww5LtkDzIkt"];
    
    [PFFacebookUtils initializeFacebook];
    
    [PFTwitterUtils initializeWithConsumerKey:@"EUjMsvd3sfUv6fJZ0BbSUsCf0"
                               consumerSecret:@"mjxX3vgaumhJRi1OLNUgN6iUX6BQJPfdArX89SErYNSLckwACH"];
    
    
    SimpleAuth.configuration[@"instagram"] = @{
        @"client_id" : @"6aeb283e3011433a8e693055957bd95c",
        SimpleAuthRedirectURIKey : @"onemessenger://auth/instagram"
    };

    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}







@end
