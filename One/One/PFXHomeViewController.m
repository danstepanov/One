//
//  PFXHomeViewController.m
//  one
//
//  Created by Siberia on 7/27/14.
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
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
	[self.view addGestureRecognizer:tap];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dismiss {
	[self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)logInPushed:(id)sender {
    LoginViewController *logIn = [self.storyboard instantiateViewControllerWithIdentifier:@"logIn"];
    [self presentViewController:logIn animated:YES completion:nil];
}

- (IBAction)signUpPushed:(id)sender {
    SignUpViewController *signUp = [self.storyboard instantiateViewControllerWithIdentifier:@"signUp"];
    [self presentViewController:signUp animated:YES completion:nil];
}

@end
