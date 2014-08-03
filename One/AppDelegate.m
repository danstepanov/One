//
//  AppDelegate.m
//  One
//
//  Created by Daniel Stepanov on 7/17/14.
//
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, weak) UIStoryboard *storyboard;
@property (nonatomic, strong) PFXHomeViewController *homeVC;
@property (nonatomic, strong) UINavigationController* authNC;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"QUCJSQNfkxKOFyoLf39E0p7pAKmayU9HiiGEfdRU"
                  clientKey:@"gUV6R2z7S41gGsXpqCE3aeDjJ9kCpww5LtkDzIkt"];
    
    [PFFacebookUtils initializeFacebook];
    
    [PFTwitterUtils initializeWithConsumerKey:@"EUjMsvd3sfUv6fJZ0BbSUsCf0"
                               consumerSecret:@"mjxX3vgaumhJRi1OLNUgN6iUX6BQJPfdArX89SErYNSLckwACH"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Do all the UI stuff
    [self setUpUserInterface];
    [self fadeInApplication];
    [self ensureLogIn];
    
	//The fuck does this do
    /*NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	if (![prefs boolForKey:@"LaunchedOnce"]) {
		[self performSelector:@selector(displayDemoView) withObject:nil afterDelay:1.0];
		[prefs setBool:YES forKey:@"LaunchedOnce"];
	}
	[self performSelector:@selector(fadeInApplication) withObject:nil afterDelay:.2];*/
	
    return YES;
}

- (void)ensureLogIn {
    // Check if we're logged in on Parse and do that shit if necessary
    NSLog(@"%@", self.storyboard);
    
    if ([PFUser currentUser] == nil) {

        
        UIViewController *home = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
        NSLog(@"Pointer to newly instantiated VC: %@", home);
        
        [self.window.rootViewController presentViewController:home animated:YES completion:^(void){
            NSLog(@"Log In/Sign Up (HomeViewController) modal has opened, pointer: %@",
                  self.window.rootViewController.presentedViewController);
        }];
    }
}

- (void)setUpUserInterface {
    
    // Override point for customization after application launch.
    UIStoryboard *storyboard = self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //The TimelineViewControler holder.
    NSLog(@"%@", self.window.rootViewController);
    
    OneTabBarController *tabBarController = (OneTabBarController *)self.window.rootViewController;
    
    OneSocialPagingViewer *oneSocialPagingViewer = [[OneSocialPagingViewer alloc] init];
    ActivityViewController *activityViewController = [[ActivityViewController alloc] init];
    MessagesViewController *messagesViewController = [[MessagesViewController alloc] init];
    ProfileViewController *profileViewContorller = [[ProfileViewController alloc] init];
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    
    //Set up individuals navigation controllers.
	UINavigationController *pageViewerNav = [[UINavigationController alloc] initWithRootViewController:oneSocialPagingViewer];
    UINavigationController *activityViewControllerNav = [[UINavigationController alloc] initWithRootViewController:activityViewController];
    UINavigationController *messagesViewControllerNav = [[UINavigationController alloc] initWithRootViewController:messagesViewController];
    UINavigationController *profileViewControllerNav = [[UINavigationController alloc] initWithRootViewController:profileViewContorller];
    UINavigationController *searchViewControllerNav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    
	[pageViewerNav.navigationBar setHidden:YES];
    
    //Set the view controllers.
    [tabBarController setViewControllers:@[pageViewerNav, activityViewControllerNav, messagesViewControllerNav, profileViewControllerNav, searchViewControllerNav]];
	[tabBarController.tabBar setFrame:CGRectMake(0, self.window.frame.size.height, tabBarController.tabBar.frame.size.width, tabBarController.tabBar.frame.size.width)];
    
    //Hopefully gets rid of navigation bar shadow
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
	
    //The pages for the TimeLineViewController
    TimelineViewController *tableViewController1 = [storyboard instantiateViewControllerWithIdentifier:@"TableViewController1"];
    TimelineViewController *tableViewController2 = [storyboard instantiateViewControllerWithIdentifier:@"TableViewController2"];
    TimelineViewController *tableViewController3 = [storyboard instantiateViewControllerWithIdentifier:@"TableViewController3"];
    TimelineViewController *tableViewController4 = [storyboard instantiateViewControllerWithIdentifier:@"TableViewController4"];
    
    /*
     Create the tabs (this could probably be done with a 'for' statement
     (maybe when the accounts are working, we'll do that)).
     */
    UITabBarItem *tab1 = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Timeline.png"] tag:1];
    [oneSocialPagingViewer setTabBarItem:tab1];
    
    UITabBarItem *activityTab = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Activity.png"] tag:1];
    [activityViewController setTabBarItem:activityTab];
    
    UITabBarItem *messagesTab = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Messages.png"] tag:1];
    [messagesViewController setTabBarItem:messagesTab];
    
    UITabBarItem *profileTab = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Profile.png"] tag:1];
    [profileViewContorller setTabBarItem:profileTab];
    
    UITabBarItem *searchTab = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Search.png"] tag:1];
    [searchViewController setTabBarItem:searchTab];
    
    //Create an array with the tab bar items.
    NSArray *tabBarArray = [[NSArray alloc] initWithObjects:tab1,activityTab,messagesTab,profileTab,searchTab, nil];
    
    //Iterate through the array.
    for (UITabBarItem *tabBarItem in tabBarArray) {
        tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
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

- (void)fadeInApplication {
	UINavigationController *vv = ((UITabBarController *)self.window.rootViewController).viewControllers[0];
	UINavigationBar *bar = vv.topViewController.navigationController.navigationBar;
	CGFloat origY = bar.frame.origin.y;
	// bar.frame = CGRectMake(0, -64, bar.frame.size.width, bar.frame.size.height);
	bar.hidden = NO;
	OneSocialPagingViewer *pg = (OneSocialPagingViewer *)[vv topViewController];
		
	[pg.centerContainerView setAlpha:0.0];
	[pg.centerContainerView setHidden:NO];
	
	UITabBarController *tb = (UITabBarController *)self.window.rootViewController;
	
	[UIView animateWithDuration:.7 animations:^ {
		[bar setFrame:CGRectMake(0, origY, bar.frame.size.width, bar.frame.size.height)];
		[tb.tabBar setFrame:CGRectMake(0, self.window.frame.size.height-tb.tabBar.frame.size.height, tb.tabBar.frame.size.width, tb.tabBar.frame.size.height)];
	} completion:^(BOOL fin) {
		[UIView beginAnimations:nil context:nil];
		[pg.centerContainerView setAlpha:1.0];
			
		[UIView commitAnimations];
	}];
	
	SystemSoundID soundID;
	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/whoosh04.wav", [[NSBundle mainBundle] resourcePath]]];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
	AudioServicesPlaySystemSound (soundID);
}
/*
- (void)displayDemoView {
	//TODO: (REMOVE)TESTING
    IntroPageViewController *intro = [[IntroPageViewController alloc] init];
    //Set the root view controller.
	[self.window.rootViewController presentModalViewController:intro animated:YES];
}*/

- (void)applicationWillResignActive:(UIApplication *)application {
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
