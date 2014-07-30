//
//  logInViewController.h
//  One
//
//  Created by Daniel Stepanov on 7/16/14.
//  Copyright (c) 2014 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface logInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *logInEmailField;
@property (weak, nonatomic) IBOutlet UITextField *logInPasswordField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loginButton;

@end
