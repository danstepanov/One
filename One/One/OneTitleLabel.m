//
//  OneTitleLabel.m
//  One
//
//  Created by Micah Benn on 7/19/14.
//
//

#import "OneTitleLabel.h"

@implementation OneTitleLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (UILabel*)labelWithText:(NSString *)text{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, [text length], 44)];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attrStr addAttribute:NSKernAttributeName value:@(0.5) range:NSMakeRange(0, attrStr.length)];
    
    return titleLabel;
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
