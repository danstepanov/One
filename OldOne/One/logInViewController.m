//
//  logInViewController.m
//  One
//
//  Created by Daniel Stepanov on 7/16/14.
//  Copyright (c) 2014 One. All rights reserved.
//

#import "logInViewController.h"

@interface logInViewController ()

@end

@implementation logInViewController

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
    self.navigationController.navigationBar.hidden = NO; //unhides nav bar
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;

    self.tabBarController.tabBar.hidden = YES; //hides tab bat
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [_logInEmailField becomeFirstResponder]; //Keeps keyboard up on view
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
                                
}


@end
