//
//  ProfileViewController.m
//  One
//
//  Created by Micah Benn on 7/17/14.
//
//

#import "ProfileViewController.h"
#import "OneTableViewCell.h"
#import "AGMedallionView.h"
#import "CAGradientLayer+OneGradientLayer.h"
#import "DZNSegmentedControl.h"
#import "UIScrollView+APParallaxHeader.h"
#import "Parse/Parse.h"
#import "PFXHomeViewController.h"



#define kHeaderHeight 310

static UILabel *facebookUsernameLabel;
static UILabel *twitterUsernameLabel;
static UILabel *instagramUsernameLabel;

static UITextView *facebookTextView;
static UITextView *twitterTextView;
static UITextView *instagramTextView;

static UIButton *facebookEditButton;
static UIButton *facebookRelationshipButton;
static UIButton *twitterEditButton;
static UIButton *twitterRelationshipButton;
static UIButton *instagramEditButton;
static UIButton *instagramRelationshipButton;

static NSArray *editButtons;
static NSArray *relationshipButtons;

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;

    //Setup the table view.
    tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    //Setup the labels.
    facebookUsernameLabel = [[UILabel alloc] init];
    twitterUsernameLabel = [[UILabel alloc] init];
    instagramUsernameLabel = [[UILabel alloc] init];
    
    facebookTextView = [[UITextView alloc] init];
    twitterTextView = [[UITextView alloc] init];
    instagramTextView = [[UITextView alloc] init];
    
    NSArray *usernameLabels = @[facebookUsernameLabel,twitterUsernameLabel,instagramUsernameLabel];
    NSArray *textViews = @[facebookTextView,twitterTextView,instagramTextView];
    
    for (UILabel *usernameLabel in usernameLabels) {
        usernameLabel.frame = CGRectMake(115, 105, 90, 90);
        usernameLabel.textAlignment = NSTextAlignmentCenter;
        usernameLabel.textColor = [UIColor whiteColor];
        usernameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    }
    
    for (UITextView *textView in textViews) {
        textView.frame = CGRectMake(10, 155, 300, 120);
        textView.backgroundColor = [UIColor clearColor];
        textView.textAlignment = NSTextAlignmentCenter;
        textView.textColor = [UIColor whiteColor];
        textView.editable = NO;
        textView.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        textView.selectable = NO;
    }
    
    //Facebook
    facebookUsernameLabel.text = @"Michael";
    facebookTextView.text = @"Software developer";
    
    //Twitter
    twitterUsernameLabel.text = @"Michael";
    twitterTextView.text = @"Developer";
    
    //Instagram
    instagramUsernameLabel.text = @"Michael";
    instagramTextView.text = @"Software developer and photographer.";
    
    //Setup the header view.
    headerView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeaderHeight)];
    
    //Set the bounds of the profile header view.
    CGRect bounds = CGRectMake(0, 0, self.view.frame.size.width, kHeaderHeight);
    
    //Set the profile header views.
    UIView *twitterProfileView = [[UIView alloc] initWithFrame:bounds];
    UIView *facebookProfileView = [[UIView alloc] initWithFrame:bounds];
    UIView *instagramProfileView = [[UIView alloc] initWithFrame:bounds];
    
    //Add the profile header views to an array.
    NSArray *profileHeaderViews = @[twitterProfileView,facebookProfileView,instagramProfileView];
    
    for (UIView *profileHeaderView in profileHeaderViews) {
        //Add the avatar image view.
        
        AGMedallionView *avatarView = [[AGMedallionView alloc] initWithFrame:CGRectMake(115, 40, 90, 90)];
        avatarView.image = [UIImage imageNamed:@"Avatar.png"];
        
        [profileHeaderView addSubview:avatarView];
        
        profileHeaderView.backgroundColor = [UIColor clearColor];

    }
    
    [facebookProfileView addSubview:facebookUsernameLabel];
    [facebookProfileView addSubview:facebookTextView];

    [twitterProfileView addSubview:twitterUsernameLabel];
    [twitterProfileView addSubview:twitterTextView];

    [instagramProfileView addSubview:instagramUsernameLabel];
    [instagramProfileView addSubview:instagramTextView];

    //Add the buttons.
    facebookEditButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    facebookRelationshipButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    twitterEditButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    twitterRelationshipButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    instagramEditButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    instagramRelationshipButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    editButtons = @[facebookEditButton,twitterEditButton,instagramEditButton];
    relationshipButtons = @[facebookRelationshipButton,twitterRelationshipButton,instagramRelationshipButton];
    
    [facebookEditButton addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookEditButton];
    
    [facebookRelationshipButton addTarget:self action:
     @selector(unfriend:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookRelationshipButton];
    
    for (UIButton *editButton in editButtons) {
        editButton.frame = CGRectMake(10, 40, 40, 10);
        [editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [editButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    }
    
    for (UIButton *relationshipButton in relationshipButtons) {
        relationshipButton.frame = CGRectMake(250, 40, 60, 10);
        [relationshipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [relationshipButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    }
    
    [facebookRelationshipButton setTitle:@"Unfriend" forState:UIControlStateNormal];
    [twitterRelationshipButton setTitle:@"Follow" forState:UIControlStateNormal];
    [instagramRelationshipButton setTitle:@"Unfollow" forState:UIControlStateNormal];
    
    twitterRelationshipButton.frame = CGRectMake(255, 40, 60, 13);
    instagramRelationshipButton.frame = CGRectMake(255, 40, 60, 20);
    facebookRelationshipButton.frame = CGRectMake(255,40,70,13);
    
    [facebookProfileView addSubview:facebookEditButton];
    [facebookProfileView addSubview:facebookRelationshipButton];
    [twitterProfileView addSubview:twitterEditButton];
    [twitterProfileView addSubview:twitterRelationshipButton];
    [instagramProfileView addSubview:instagramEditButton];
    [instagramProfileView addSubview:instagramRelationshipButton];

    [headerView addPages:@[facebookProfileView,twitterProfileView,instagramProfileView]];
    
    [self.view addSubview:tableView];
    
    [headerView setHasPageControl:YES];

}



- (void)headerDidScrollWithPercent:(CGFloat)percent{
    
    if (percent < 3.0){
        [UIView animateWithDuration:0.2 animations:^{
            for (UIButton *button in editButtons) {
                button.alpha = 0;
            }
            
            for (UIButton *button in relationshipButtons) {
                button.alpha = 0;
            }
            
        }];
    }
    
    if (percent == 0.0 || percent == 1.0 || percent == 2.0 || percent == 3.0) {
        [UIView animateWithDuration:0.2 animations:^{
            for (UIButton *button in editButtons) {
                button.alpha = 1;
            }
            
            for (UIButton *button in relationshipButtons) {
                button.alpha = 1;
            }
            
        }];
    }
}

- (IBAction)logOut:(id)sender
{
    [PFUser logOut];
    if ([PFUser currentUser] == nil) {
        NSLog(@"Root View Controller of ProfileVC: %@", self.tabBarController.storyboard);
        PFXHomeViewController *homeVC = [self.tabBarController.storyboard instantiateViewControllerWithIdentifier:@"home"];
        NSLog(@"Pointer to newly instantiated VC: %@", homeVC);
        
        [self presentViewController:homeVC animated:YES completion:^(void){
            [self.tabBarController setSelectedIndex:0];
                // This makes it so upon log in it will open to Timeline everytime.
            NSLog(@"Log In/Sign Up (HomeViewController) modal has opened, pointer: %@",
                  self.presentedViewController);
        }];
    }
}



- (void)setBackgroundColor:(UIColor*)color{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].y > 0) {
    } else {
    }
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0){
        return 0;
    }else{
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"cellIdentifier";
    
    OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OneTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(80, cell.frame.size.height, 240, 0.3)];
        separatorView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        separatorView.layer.borderWidth = 0.3;
        [cell.contentView addSubview:separatorView];
    }
    
    cell.username = @"Michael";
    cell.serviceType = kServiceTypeFacebook;
    cell.avatar = [UIImage imageNamed:@"Avatar.png"];
    cell.text = @"Hi";
    cell.time = @"1m";
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0){
        return headerView;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0){
        return kHeaderHeight;
    }else{
        return 0;
    }
}



@end
