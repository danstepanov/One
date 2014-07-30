//
//  linkAccountsViewController.h
//  One
//
//  Created by Daniel Stepanov on 7/17/14.
//  Copyright (c) 2014 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface linkAccountsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *linkFacebookButton;
@property (weak, nonatomic) IBOutlet UIButton *linkTwitterButton;
@property (weak, nonatomic) IBOutlet UIButton *linkInstagramButton;


@property (nonatomic) NSString *instagramAccessToken;
@end
