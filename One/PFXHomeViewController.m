//
//  PFXHomeViewController.m
//  one
//
//  Created by Daniel Stepanov on 7/27/14.
//
//

#import "PFXHomeViewController.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"

@interface PFXHomeViewController ()

@end

@implementation PFXHomeViewController

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
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([PFUser currentUser] != nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)logInPushed:(id)sender {
    LoginViewController *logIn = [self.storyboard instantiateViewControllerWithIdentifier:@"logIn"];
        [self presentViewController:logIn animated:YES completion:nil];
    
}

- (IBAction)signUpPushed:(id)sender {
    SignUpViewController *signUp = [self.storyboard instantiateViewControllerWithIdentifier:@"signUp"];
        [self presentViewController:signUp animated:YES completion:nil];
    
}

@end
