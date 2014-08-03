//
//  linkingAccountsViewController.m
//  one
//
//  Created by Daniel Stepanov on 8/1/14.
//
//

#import "linkingAccountsViewController.h"
#import "PFXHomeViewController.h"
#import "Parse/Parse.h"
#import <FacebookSDK/FacebookSDK.h>

@interface linkingAccountsViewController ()

@end

@implementation linkingAccountsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([PFTwitterUtils isLinkedWithUser:[PFUser currentUser]]) {
        
         NSLog(@"Woohoo, user logged in with Twitter!");
    }
    
    if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        
        NSLog(@"Woohoo, user logged in with Facebook!");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismiss {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentNewUserIntro {
    // TODO: real into presentation whatever something legitimate
    [self dismiss];
}

- (void)completeSignUp {
    [self dismissViewControllerAnimated:YES completion:^ {
        [self presentNewUserIntro];
    }];
}

- (IBAction)linkFacebookButtonTouched:(id)sender {
    //if Facebook is not linked, button reads "Link Facebook" and on click, the user logs in with FB linking their account to Parse
    //else if Facebook is linked, button reads "Facebook Linked" and on click, the user's FB account is unlinked from Parse
    
    PFUser *user = [PFUser currentUser];
    if (![PFFacebookUtils isLinkedWithUser:user]) {
        [PFFacebookUtils linkUser:user permissions:nil block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Woohoo, user logged in with Facebook!");
            }
        }];
    } else {
        [PFFacebookUtils unlinkUserInBackground:user block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"The user is no longer associated with their Facebook account.");
            }
        }];
    }
}


- (IBAction)linkTwitterButtonTouched:(id)sender {
    PFUser *user = [PFUser currentUser];
    if (![PFTwitterUtils isLinkedWithUser:user]) {
        [PFTwitterUtils linkUser:user block:^(BOOL succeeded, NSError *error) {
            if ([PFTwitterUtils isLinkedWithUser:user]) {
                NSLog(@"Woohoo, user logged in with Twitter!");
                
            }
        }];
    } else {
        [PFTwitterUtils unlinkUserInBackground:user block:^(BOOL succeeded, NSError *error) {
            if (!error && succeeded) {
                NSLog(@"The user is no longer associated with their Twitter account.");
            }
        }];
    }
}

- (IBAction)linkInstagramButtonTouched:(id)sender {
    
}

- (IBAction)linkAccountsDoneButtonTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
