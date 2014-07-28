//
//  PFXScrollView.m
//  one
//
//  Created by Siberia on 7/27/14.
//
//

#import "PFXScrollView.h"

@implementation PFXScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	return NO;
}
@end
