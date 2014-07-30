//
//  LoginViewController.h
//  one
//
//  Created by William Gu on 7/26/14.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Parse/Parse.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>
- (void)playSignInSound;
@property (weak, nonatomic) IBOutlet UITextField *loginEmailField;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *loginBackButton;
@property (weak, nonatomic) IBOutlet UILabel *loginForgotPasswordButton;
@end
