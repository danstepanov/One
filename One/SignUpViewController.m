//
//  SignUpViewController.m
//  One
//
//  Created by Daniel Stepanov on 7/28/14.
//
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "linkingAccountsViewController.h"

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

- (void)viewDidAppear:(BOOL)animated
{
    
    [_signupEmailField becomeFirstResponder]; //Keeps keyboard up on view
    if ([PFUser currentUser] != nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signupBackButtonTouched:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signupDoneButtonTouched:(id)sender{

    // 1. Get field text + trim whitespace
    NSString *email = [self.signupEmailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.signupPasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
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
                linkingAccountsViewController *linking = [self.storyboard instantiateViewControllerWithIdentifier:@"linking"];
                [self presentViewController:linking animated:YES completion:nil];
            }
        }];
    }
    
}
@end
