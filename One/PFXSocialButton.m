//
//  PFXSocialButton.m
//  one
//
//  Created by Siberia on 7/27/14.
//
//

#import "PFXSocialButton.h"

@implementation PFXSocialButton

- (id)init {
	if ((self = [super init])) {
		self.label = [[UILabel alloc] init];
		self.imageView = [[UIImageView alloc] init];
		[self addSubview:self.label];
		[self addSubview:self.imageView];
		
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.imageView.frame = CGRectMake(5, 5, self.frame.size.height - 10, self.frame.size.height - 10);
	self.label.frame = CGRectMake(5 + self.frame.size.height - 10, self.frame.size.height/2 - 12, self.frame.size.width - (self.frame.size.height - 10) - 5, 10);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
