//
//  OneTableViewCell.m
//  One
//
//  Created by Micah Benn on 7/17/14.
//
//

#import "OneTableViewCell.h"

@implementation OneTableViewCell
@synthesize username,text,avatar,serviceType,time, serviceLabel, usernameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setServiceType:(kServiceType)serviceType_{
    
    if (serviceType_ == kServiceTypeTwitter){
        serviceLabel.text = @"Twitter";
        serviceLabel.textColor = [UIColor twitterNavBarColor];
    }else if (serviceType_ == kServiceTypeFacebook){
        serviceLabel.text = @"Facebook";
        serviceLabel.textColor = [UIColor facebookNavBarColor];
    }else if (serviceType_ == kServiceTypeInstagram){
        serviceLabel.text = @"Instagram";
        serviceLabel.textColor = [UIColor instagramNavBarColor];
    }
}


- (void)layoutSubviews{
        
    avatarImageView.image = avatar;
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:username];
    [attrStr addAttribute:NSKernAttributeName value:@(0.5) range:NSMakeRange(0, attrStr.length)];
    usernameLabel.attributedText = attrStr;
}

@end
