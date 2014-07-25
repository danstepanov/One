//
//  AppDelegate.m
//  One
//
//  Created by Micah Benn on 7/17/14.
//
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, weak) UIStoryboard *storyboard;
@property (nonatomic, strong) HomeViewController *homeVC;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // DO SOME SHIT WITH DATA
    [Parse setApplicationId:@"QUCJSQNfkxKOFyoLf39E0p7pAKmayU9HiiGEfdRU"
                  clientKey:@"gUV6R2z7S41gGsXpqCE3aeDjJ9kCpww5LtkDzIkt"];
    
    [PFFacebookUtils initializeFacebook];
    
    [PFTwitterUtils initializeWithConsumerKey:@"EUjMsvd3sfUv6fJZ0BbSUsCf0"
                               consumerSecret:@"mjxX3vgaumhJRi1OLNUgN6iUX6BQJPfdArX89SErYNSLckwACH"];
    
    
    SimpleAuth.configuration[@"instagram"] = @{
                                               @"client_id": @"6aeb283e3011433a8e693055957bd95c",
                                               SimpleAuthRedirectURIKey: @"onemessenger://auth/instagram"
                                               };
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Do all the UI stuff
    [self setUpUserInterface];
    [self ensureLogIn];
    
    return YES;
}

- (void)ensureLogIn {
    // Check if we're logged in on Parse and do that shit if necessary
    if ([PFUser currentUser] == nil) {
        HomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        NSLog(@"Pointer to newly instantiated VC: %@", homeVC);
        
        [self.window.rootViewController presentViewController:homeVC animated:YES completion:^(void){
            NSLog(@"Log In/Sign Up (HomeViewController) modal has opened, pointer: %@",
                  self.window.rootViewController.presentedViewController);
        }];
    }
}

- (void)setUpUserInterface
{
    // Override point for customization after application launch.
    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    OneTabBarController *tabBarController = (OneTabBarController *)self.window.rootViewController;
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNavigationController"];
    
    //The TimelineViewControler holder.
    OneSocialPagingViewer *oneSocialPagingViewer = (OneSocialPagingViewer *)navigationController.topViewController;
    
    ActivityViewController *activityViewController = [[ActivityViewController alloc] init];
    MessagesViewController *messagesViewController = [[MessagesViewController alloc] init];
    ProfileViewController *profileViewContorller = [[ProfileViewController alloc] init];
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    
    //Set up individuals navigation controllers.
    UINavigationController *activityViewControllerNav = [[UINavigationController alloc] initWithRootViewController:activityViewController];
    UINavigationController *messagesViewControllerNav = [[UINavigationController alloc] initWithRootViewController:messagesViewController];
    UINavigationController *profileViewControllerNav = [[UINavigationController alloc] initWithRootViewController:profileViewContorller];
    UINavigationController *searchViewControllerNav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    
    //Set the view controllers.
    [tabBarController setViewControllers:@[navigationController, activityViewControllerNav, messagesViewControllerNav, profileViewControllerNav, searchViewControllerNav]];
    
    //Set the root view controller.
    self.window.rootViewController = tabBarController;
    
    //The pages for the TimeLineViewController
    TimelineViewController *tableViewController1 = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController1"];
    TimelineViewController *tableViewController2 = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController2"];
    TimelineViewController *tableViewController3 = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController3"];
    TimelineViewController *tableViewController4 = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController4"];
    
    /*
     Create the tabs (this could probably be done with a 'for' statement
     (maybe when the accounts are working, we'll do that).
     */
    UITabBarItem *feedTab = [[UITabBarItem alloc] initWithTitle:@"Feed" image:[UIImage imageNamed:@"Timeline.png"] tag:1];
    [oneSocialPagingViewer setTabBarItem:feedTab];
    
    UITabBarItem *activityTab = [[UITabBarItem alloc] initWithTitle:@"Activity" image:[UIImage imageNamed:@"Activity.png"] tag:1];
    [activityViewController setTabBarItem:activityTab];
    
    UITabBarItem *messagesTab = [[UITabBarItem alloc] initWithTitle:@"Messages" image:[UIImage imageNamed:@"Messages.png"] tag:1];
    [messagesViewController setTabBarItem:messagesTab];
    
    UITabBarItem *profileTab = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[UIImage imageNamed:@"Profile.png"] tag:1];
    [profileViewContorller setTabBarItem:profileTab];
    
    UITabBarItem *searchTab = [[UITabBarItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@"Search.png"] tag:1];
    [searchViewController setTabBarItem:searchTab];
    
    //Create an array with the tab bar items.
    NSArray *tabBarArray = [[NSArray alloc] initWithObjects:feedTab,activityTab,messagesTab,profileTab,searchTab, nil];
    
    //Iterate through the array
    for (UITabBarItem *tabBarItem in tabBarArray) {
        // Move the tabBarItem image down vertically within the navigation bar
        //tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    }
    
    //Set the pages for the TimeLineViewController.
    oneSocialPagingViewer.viewControllers = @[tableViewController1, tableViewController2, tableViewController3, tableViewController4];
    
    [self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
