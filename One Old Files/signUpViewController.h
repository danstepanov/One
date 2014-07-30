//
//  signUpViewController.h
//  One
//
//  Created by Daniel Stepanov on 7/16/14.
//  Copyright (c) 2014 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface signUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *signUpPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *signUpEmailField;

@end
