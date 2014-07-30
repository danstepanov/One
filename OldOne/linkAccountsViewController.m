//
//  linkAccountsViewController.m
//  One
//
//  Created by Daniel Stepanov on 7/17/14.
//  Copyright (c) 2014 One. All rights reserved.
//

#import "linkAccountsViewController.h"
#import <SimpleAuth/SimpleAuth.h>

@interface linkAccountsViewController ()

@end

@implementation linkAccountsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    // Hides the top navigation bar
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    // Hides the bottom tab bar
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSegueWithIdentifier:@"showLogin" sender:self]; //load the login page first
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults]; //Create a NSUserDefault object called "userDefaults" set to the shared defaults object, creates a variable for the userDefaults class which sets a user's default behavior
    self.instagramAccessToken = [userDefaults objectForKey:@"instagramAccessToken"]; //Set the value of "instagramAccessToken" string to the the userDefault's object value, nil if key not found (aka user has never signed in)
    
    if ([PFTwitterUtils isLinkedWithUser:[PFUser currentUser]]) {
        [self.linkTwitterButton setTitle:@"Twitter Linked" forState:UIControlStateNormal];
        NSLog(@"Woohoo, user logged in with Twitter!");
    }
    
    if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        [self.linkFacebookButton setTitle:@"Facebook Linked" forState:UIControlStateNormal];
        NSLog(@"Woohoo, user logged in with Facebook!");
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)facebookButtonTouched:(id)sender {
    //if Facebook is not linked, button reads "Link Facebook" and on click, the user logs in with FB linking their account to Parse
    //else if Facebook is linked, button reads "Facebook Linked" and on click, the user's FB account is unlinked from Parse
    
    PFUser *user = [PFUser currentUser];
    if (![PFFacebookUtils isLinkedWithUser:user]) {
        [PFFacebookUtils linkUser:user permissions:nil block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [sender setTitle:@"Facebook Linked" forState:UIControlStateNormal];
                NSLog(@"Woohoo, user logged in with Facebook!");
            }
        }];
    } else {
        [PFFacebookUtils unlinkUserInBackground:user block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [sender setTitle:@"Link Facebook" forState:UIControlStateNormal];
                NSLog(@"The user is no longer associated with their Facebook account.");
            }
        }];
    }
}

 - (IBAction)twitterButtonTouched:(id)sender {
     PFUser *user = [PFUser currentUser];
     if (![PFTwitterUtils isLinkedWithUser:user]) {
         [PFTwitterUtils linkUser:user block:^(BOOL succeeded, NSError *error) {
             if ([PFTwitterUtils isLinkedWithUser:user]) {
                 [sender setTitle:@"Twitter Linked" forState:UIControlStateNormal];
                 NSLog(@"Woohoo, user logged in with Twitter!");
             }
         }];
     } else {
         [PFTwitterUtils unlinkUserInBackground:user block:^(BOOL succeeded, NSError *error) {
             if (!error && succeeded) {
                 [sender setTitle:@"Link Twitter" forState:UIControlStateNormal];
                 NSLog(@"The user is no longer associated with their Twitter account.");
             }
         }];
     }


}

- (IBAction)instagramButtonTouched:(id)sender {
    
    if (self.instagramAccessToken == nil) {//checks if the token has been previously set
        //in the event that the user has never logged in, triggers SimpleAuth cocoapod
        
        //authorize instagram via SimpleAuth
        [SimpleAuth authorize:@"instagram" completion:^(NSDictionary *responseObject, NSError *error) {
            NSLog(@"%@", responseObject);
            NSString *instagramAccessToken = responseObject[@"credentials"][@"token"];
        
            [[NSUserDefaults standardUserDefaults] setObject:instagramAccessToken forKey:@"instagramAccessToken"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [sender setTitle:@"Instagram Linked" forState:UIControlStateNormal];
        }];
        
    } else {
        NSLog(@"The user is no longer associated with their Instagram account.");
    }
}

- (IBAction)doneButtonTouched:(id)sender {
    [self performSegueWithIdentifier:@"showFeed" sender:self];
}



@end
