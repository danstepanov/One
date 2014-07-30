//
//  SignUpViewController.h
//  One
//
//  Created by Sam Moore on 7/28/14.
//
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
- (IBAction)donePushed:(id)sender;
- (IBAction)backPushed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end
