//
//  TimelineViewController.h
//  One
//
//  Created by Micah Benn on 7/17/14.
//
//

#import <UIKit/UIKit.h>
#import "UIColor+OneColor.h"
#import "OneBaseTableViewController.h"
#import "PFXSocialButton.h"

@interface TimelineViewController : OneBaseTableViewController {
	NSIndexPath *expandedPath;
}

@property (nonatomic, assign) BOOL showPushDetail;

@end
