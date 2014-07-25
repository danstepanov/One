//
//  CAGradientLayer+OneGradientLayer.m
//  One
//
//  Created by Micah Benn on 7/19/14.
//
//

#import "CAGradientLayer+OneGradientLayer.h"

@implementation CAGradientLayer (OneGradientLayer)

+ (CAGradientLayer*)twitterGradientLayer{
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor twitterGradientEndColor] CGColor], (id)[[UIColor twitterGradientStartColor] CGColor], nil];
    gradient.frame = CGRectMake(0, 0, 320, 310);
    
    return gradient;
}

+ (CAGradientLayer*)facebookGradientLayer{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor facebookGradientEndColor] CGColor], (id)[[UIColor facebookGradientStartColor] CGColor], nil];
    gradient.frame = CGRectMake(0, 0, 320, 310);
    
    return gradient;
}

+ (CAGradientLayer*)instagramGradientLayer{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor instagramGradientEndColor] CGColor], (id)[[UIColor instagramGradientStartColor] CGColor], nil];
    gradient.frame = CGRectMake(0, 0, 320, 310);
    
    return gradient;
}

@end
