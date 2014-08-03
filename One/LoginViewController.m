//
//  LoginViewController.m
//  one
//
//  Created by Daniel Stepanov on 7/26/14.
//
//

#import "LoginViewController.h"
#import "PFXHomeViewController.h"


@interface LoginViewController ()



@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
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
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [_loginEmailField becomeFirstResponder]; //Keeps keyboard up on view
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shakeTextField:(UITextField *)field {
	
}

- (void)playSignInSound {
	SystemSoundID soundID;
	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/success.mp3", [[NSBundle mainBundle] resourcePath]]];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
	AudioServicesPlaySystemSound (soundID);
}

- (IBAction)loginButtonTouched:(id)sender {
    NSString *email = [[self.loginEmailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseStringWithLocale:nil];
    NSString *password = [self.loginPasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([email length] == 0 || [password length] == 0 ) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Make sure you enter a valid email and password!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    else {
        [PFUser logInWithUsernameInBackground:email password:password block:^(PFUser *user, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc]    initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            else {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }

}

- (IBAction)loginBackButtonTouched:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // if password is incorrect
    //{
    /*
     
     CABasicAnimation *animation =
     [CABasicAnimation animationWithKeyPath:@"position"];
     [animation setDuration:0.05];
     [animation setRepeatCount:8];
     [animation setAutoreverses:YES];
     [animation setFromValue:[NSValue valueWithCGPoint:
     CGPointMake([lockView center].x - 20.0f, [lockView center].y)]];
     [animation setToValue:[NSValue valueWithCGPoint:
     CGPointMake([lockView center].x + 20.0f, [lockView center].y)]];
     [[lockView layer] addAnimation:animation forKey:@"position"];
    
     
     OR some other animation
    */
    //}
    
    
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

@end
