//
//  IntroPageViewController.m
//  one
//
//  Created by William Gu on 7/26/14.
//
//

#import "IntroPageViewController.h"
#import <objc/runtime.h>

@interface IntroPageViewController ()

@property (assign, nonatomic) NSInteger index;

@end

@implementation IntroPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Pop 1.mp3", [[NSBundle mainBundle] resourcePath]]];
		NSLog(@"fds %@", url);
		AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	lockScroll = [[PFXScrollView alloc] init];
	[lockScroll setShowsHorizontalScrollIndicator:NO];
	[lockScroll setShowsVerticalScrollIndicator:NO];
    scrollView = [[UIScrollView alloc] init];
	scrollView.pagingEnabled = YES;
	scrollView.backgroundColor = UIColorFromRGB(0xf2f2f2);
	scrollView.delegate = self;
	scrollView.bounces = NO;
	scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	for (int x = 0; x < 4; x++) {
		PFXBaseIntroViewController *vvv = (PFXBaseIntroViewController *)[self viewControllerAtIndex:x];
		[vvv viewDidLoad];
		[scrollView addSubview:vvv.view];
		UIImageView *img = [[UIImageView alloc] initWithImage:[[vvv iPhoneImage] image]];
		[img setContentMode:UIViewContentModeScaleAspectFit];
		[[vvv iPhoneImage] removeFromSuperview];
		[lockScroll addSubview:img];
		[img setFrame:CGRectMake((self.view.frame.size.width)*x +20, img.frame.origin.y+10, 277, 360)];
		[vvv.view setFrame:CGRectMake(self.view.frame.size.width*x, 0, self.view.frame.size.width, self.view.frame.size.height)];
		if (x == 3) {
			UITapGestureRecognizer *gg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissThis)];
			[vvv.view addGestureRecognizer:gg];
		}
	}
	[lockScroll setScrollEnabled:NO];
	[lockScroll setContentSize:CGSizeMake(4*self.view.frame.size.width, self.view.frame.size.height)];
	[lockScroll setFrame:CGRectMake(0, 200, 320, 480)];

	[scrollView setContentSize:CGSizeMake(4*self.view.frame.size.width, self.view.frame.size.height)];
	[self.view addSubview:scrollView];
	[self.view addSubview:lockScroll];
	[self.view bringSubviewToFront:lockScroll];
}

- (void)scrollViewDidScroll:(UIScrollView *)sv {
	int fdx = (int)floor([sv contentOffset].x/self.view.frame.size.width);
	if (fdx != idx) {
		idx = fdx;
		AudioServicesPlaySystemSound(soundID);
		[lockScroll setContentOffset:CGPointMake(idx*320, 0) animated:YES];
	}
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {

    NSUInteger index = [(IntroPageViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (void)dismissThis {
	[self dismissViewControllerAnimated:YES completion:NULL];
	[self performSelector:@selector(presentHomeVC) withObject:nil afterDelay:.7];
}

- (void)presentHomeVC {
	UIViewController *home = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"home"];
	[[[[UIApplication sharedApplication] keyWindow] rootViewController] presentModalViewController:home animated:YES];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(IntroPageViewController *)viewController index];
    if (index == 3) {
		UITapGestureRecognizer *fin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissThis)];
		[viewController.view addGestureRecognizer:fin];
        return nil;
    }
    
	index++;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	PFXBaseIntroViewController *active = (PFXBaseIntroViewController *)[sb instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%dAAA", index+1]];
	[active setIndex:index];
	return active;
	
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
