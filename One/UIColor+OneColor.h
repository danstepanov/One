//
//  UIColor+OneColor.h
//  One
//
//  Created by Micah Benn on 7/17/14.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (OneColor)

//UInavigationBar colors.
+ (UIColor*)twitterNavBarColor;
+ (UIColor*)facebookNavBarColor;
+ (UIColor*)instagramNavBarColor;

//UIPageControl colors.
+ (UIColor*)pageControlDotColor;

//General colors.
+ (UIColor*)flatLightBlueColor;

//Gradient colors.
+ (UIColor*)twitterGradientStartColor;
+ (UIColor*)twitterGradientEndColor;

+ (UIColor*)facebookGradientStartColor;
+ (UIColor*)facebookGradientEndColor;

+ (UIColor*)instagramGradientStartColor;
+ (UIColor*)instagramGradientEndColor;

@end
