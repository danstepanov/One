//
//  LoginViewController.h
//  one
//
//  Created by Daniel Stepanov on 7/26/14.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Parse/Parse.h"
#import "BaseViewController.h"

@interface LoginViewController : BaseViewController <UITextFieldDelegate>
- (void)playSignInSound;
- (IBAction)loginButtonTouched:(id)sender;
- (IBAction)loginBackButtonTouched:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *loginEmailField;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *loginForgotPasswordButton;
@end
