//
//  SignUpViewController.m
//  One
//
//  Created by Sam Moore on 7/28/14.
//
//

#import "SignUpViewController.h"
#import "PFXHomeViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)donePushed:(id)sender {

    // 1. Get field text + trim whitespace
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // make sure the user doesn't suck
    if ([email length] == 0 || [password length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                            message:@"Make sure you enter a valid email address and password!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    else // TODO: okay so they passed our only method of verification... for now...
    { // create the acct gurl
    
        PFUser *newUser = [PFUser user];
        newUser.username = email;
        newUser.email    = email;
        newUser.password = password;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                                    message:[error.userInfo objectForKey:@"error"]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
            } else {
                [(PFXHomeViewController *)self.presentingViewController completeSignUp];
            }
        }];
    }
    
}

- (IBAction)backPushed:(id)sender {
}


@end
