//
//  OneTabBarController.m
//  One
//
//  Created by Micah Benn on 7/17/14.
//
//

#import "OneTabBarController.h"

@interface OneTabBarController ()

@end

@implementation OneTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
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
    self.tabBar.selectedImageTintColor = [UIColor flatLightBlueColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewDidLayoutSubviews{
//    CGFloat tabBarHeight = 44.0;
//    CGRect frame = self.view.frame;
//    self.tabBar.frame = CGRectMake(0, frame.size.height - tabBarHeight, frame.size.width, tabBarHeight);
//    
//}

@end
