//
//  SignUpViewController.h
//  One
//
//  Created by Daniel Stepanov on 7/28/14.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SignUpViewController : BaseViewController
- (IBAction)signupDoneButtonTouched:(id)sender;
- (IBAction)signupBackButtonTouched:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *signupEmailField;
@property (weak, nonatomic) IBOutlet UITextField *signupPasswordField;

@end
