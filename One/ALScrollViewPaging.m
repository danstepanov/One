//
//  ALScrollViewPaging.m
//  ScrollViewPaging
//
//  Created by Andrea Lufino on 15/02/13.
//  Copyright (c) 2013 Andrea Lufino. All rights reserved.
//

#import "ALScrollViewPaging.h"
#import "ProfileViewController.h"
#import "CAGradientLayer+OneGradientLayer.h"

@implementation ALScrollViewPaging

const int kDotWidth = 3;

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //setting the 'must have' properties
        self.pagingEnabled = YES;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        pageControlBeingUsed = NO;
        self.bounces = NO;
        pageControl = [[UIPageControl alloc] init];
        
        self.backgroundColor = [UIColor colorWithPatternImage:[self facebookGradient]];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pages
{
    self = [super initWithFrame:frame];
    if (self) {
        //add pages to scrollview
        [self addPages:pages];
    }
    return self;
}

#pragma mark - Setter

//setter for hasPageControl property
//if is YES, we can create the page control and place it under the scrollview
- (void)setHasPageControl:(BOOL)hasPageControl {
    _hasPageControl = hasPageControl;
    //if hasPageControl is true
    if (hasPageControl) {
        //set number of page based on number of pages to show and set current page to the first object
        [pageControl setNumberOfPages:[_pages count]];
        [pageControl setCurrentPage:0];
        //calculate the page control width considering that a dot is 20px, so we can multiply by the number of page to have the width of the page control
        int pWidth = kDotWidth * [_pages count];
        //calculate the scroll view center
        CGFloat scrollViewCenterPointX = self.frame.size.width / 2;
        //calculate the X and Y coordinates of the page control
        int pageControlX = scrollViewCenterPointX - (pWidth / 2);
        //set the frame of the page control
        [pageControl setFrame:CGRectMake(pageControlX, 230, pWidth, 36)];
        //set target and selector for page control
        [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        //set colors for indicators
        [pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
        [pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
        //add page control to superview
        [self.superview addSubview:pageControl];
        
    } else {
        //remove the page control from superview
        for (UIPageControl *pControl in [[self superview] subviews]) {
            if ([pControl isEqual:pageControl]) {
                [pageControl removeFromSuperview];
            }
        }
    }
}

//set the color of the current page dot
- (void)setPageControlCurrentPageColor:(UIColor *)pageControlCurrentPageColor {
    _pageControlCurrentPageColor = pageControlCurrentPageColor;
    pageControl.currentPageIndicatorTintColor = pageControlCurrentPageColor;
}

//set the color of the others pages indicators
- (void)setPageControlOtherPagesColor:(UIColor *)pageControlOtherPagesColor {
    _pageControlOtherPagesColor = pageControlOtherPagesColor;
    pageControl.pageIndicatorTintColor = pageControlOtherPagesColor;
}

#pragma mark - Add pages

//add pages to the scrollview
- (void)addPages:(NSArray *)pages {
    _pages = pages;
    int numberOfPages = [pages count];
    for (int i = 0; i < [pages count]; i++) {
        CGRect frame;
        frame.origin.x = self.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.frame.size;
        UIView *view = [pages objectAtIndex:i];
        [view setFrame:frame];
        [self addSubview:view];
    }
    self.contentSize = CGSizeMake(self.frame.size.width * numberOfPages, self.frame.size.height);
}

#pragma mark - Change page through page control

//method for paging
- (void)changePage:(id)sender {
    //update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = self.frame.size.width * pageControl.currentPage;
	frame.origin.y = 0;
	frame.size = self.frame.size;
	[self scrollRectToVisible:frame animated:YES];
	pageControlBeingUsed = YES;
    
}

#pragma mark - ScrollView delegate

//methods for paging
- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
		//switch the page when more than 50% of the previous/next page is visible
		CGFloat pageWidth = self.frame.size.width;
		NSInteger page = floor((self.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		self.currentPage = page;
        pageControl.currentPage = self.currentPage;
     
//        if (sender.contentOffset.y != 0) {
//            CGPoint offset = sender.contentOffset;
//            offset.y = 0;
//            sender.contentOffset = offset;
//        }

        CGFloat offset = sender.contentOffset.x+sender.contentInset.right;
        CGFloat startLoadingThreshold = 320.0;
        CGFloat fractionDragged       = offset/startLoadingThreshold;
        
        ProfileViewController *profileViewController = [[ProfileViewController alloc] init];
        [profileViewController headerDidScrollWithPercent:fractionDragged];
        
        if (page == 0){
            self.backgroundColor = [UIColor colorWithPatternImage:[self facebookGradient]];
            [profileViewController setBackgroundColor:[UIColor facebookGradientEndColor]];
        }else if (page == 1){
            self.backgroundColor = [UIColor colorWithPatternImage:[self twitterGradient]];
            [profileViewController setBackgroundColor:[UIColor twitterGradientEndColor]];
        }else if (page == 2){
            self.backgroundColor = [UIColor colorWithPatternImage:[self instagramGradient]];
            [profileViewController setBackgroundColor:[UIColor instagramGradientEndColor]];
        }
        
        
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

#pragma mark Gradeints

- (UIImage*)twitterGradient{
    UIGraphicsBeginImageContext([[CAGradientLayer twitterGradientLayer] frame].size);
    [[CAGradientLayer twitterGradientLayer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (UIImage*)facebookGradient{
    UIGraphicsBeginImageContext([[CAGradientLayer facebookGradientLayer] frame].size);
    [[CAGradientLayer facebookGradientLayer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (UIImage*)instagramGradient{
    UIGraphicsBeginImageContext([[CAGradientLayer instagramGradientLayer] frame].size);
    [[CAGradientLayer instagramGradientLayer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
