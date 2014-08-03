//
//  IntroPageViewController.h
//  one
//
//  Created by William Gu on 7/26/14.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "PFXBaseIntroViewController.h"
#import "PFXScrollView.h"
#import "BaseViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface IntroPageViewController : BaseViewController <UIScrollViewDelegate> {
	UIScrollView *scrollView;
	int idx;
	SystemSoundID soundID;
	UIScrollView *lockScroll;
}
@end
