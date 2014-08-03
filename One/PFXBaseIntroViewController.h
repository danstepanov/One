//
//  PFXBaseIntroViewController.h
//  one
//
//  Created by Siberia on 7/26/14.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PFXBaseIntroViewController : BaseViewController {
}
@property (nonatomic, assign, getter=index) int index;
@property (nonatomic, retain) IBOutlet UIImageView *iPhoneImage;
@end
