//
//  feedViewController.m
//  One
//
//  Created by Daniel Stepanov on 7/16/14.
//  Copyright (c) 2014 One. All rights reserved.
//

#import "feedViewController.h"

@interface feedViewController ()

@end

@implementation feedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    // Hides the top navigation bar
    self.navigationController.navigationBar.hidden = NO;
    // Hides the bottom tab bar
    self.tabBarController.tabBar.hidden = YES;
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSegueWithIdentifier:@"showLogin" sender:self]; //load the login page first
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
