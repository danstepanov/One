//
//  XHPaggingNavbar.m
//  XHTwitterPagging
//
//  Created by 曾 宪华 on 14-6-20.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "OnePagingNavBar.h"
#import "DDPageControl.h"

#define kIPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define kLabelBaseTag 1000

static UILabel *titleLabel;

@interface OnePagingNavBar ()

@property (nonatomic, strong) DDPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *titleLabels;

@end

@implementation OnePagingNavBar

#pragma mark - DataSource

- (void)reloadData {
    if (!self.titles.count) {
        return;
    }
    
    [self.titleLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
        label.hidden = YES;
    }];
    
    [self.titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
        CGRect titleLabelFrame = CGRectMake((idx * (kIPad ? 320 : 100)), 3, CGRectGetWidth(self.bounds), 20);
        titleLabel = (UILabel *)[self viewWithTag:kLabelBaseTag + idx];
        
        if (!titleLabel) {
            titleLabel = [[UILabel alloc] init];
            [self addSubview:titleLabel];
            
            [self.titleLabels addObject:titleLabel];
        }
        titleLabel.hidden = NO;
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:title];
        [attrStr addAttribute:NSKernAttributeName value:@(0.5) range:NSMakeRange(0, attrStr.length)];
        
        titleLabel.attributedText = attrStr;
        titleLabel.frame = titleLabelFrame;
        
        if ([title isEqualToString:@"Timeline"]){
            titleLabel.textColor = [UIColor blackColor];
        }else{
            titleLabel.textColor = [UIColor whiteColor];
        }
        
        if (self.currentPage == idx) {
            titleLabel.alpha = 1.0;
        } else {
            titleLabel.alpha = 0.0;
        }
        
    }];
    
    self.pageControl.onColor = [UIColor pageControlDotColor];
    self.pageControl.offColor = [UIColor colorWithWhite: 0.7f alpha: 0.5f];
    
    
    self.pageControl.numberOfPages = self.titles.count;
}

#pragma mark - Propertys

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    self.pageControl.currentPage = currentPage;
    
    UIColor *onColor;
    UIColor *offColor;
    
    if (currentPage == 0){
        onColor = [UIColor pageControlDotColor];
        offColor = [UIColor colorWithWhite: 0.7f alpha: 0.5f];
    }else{
        onColor = [UIColor whiteColor];
        offColor = [UIColor colorWithWhite: 1.0f alpha: 0.5f];
    }
    
    self.pageControl.onColor = onColor;
    self.pageControl.offColor = offColor;

}

- (void)percentSwiped:(CGFloat )percent{

}

- (void)setContentOffset:(CGPoint)contentOffset {
    
    _contentOffset = contentOffset;
    
    CGFloat xOffset = contentOffset.x;
    
    CGFloat normalWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    [self.titleLabels enumerateObjectsUsingBlock:^(UILabel *titleLabel, NSUInteger idx, BOOL *stop) {
        if ([titleLabel isKindOfClass:[UILabel class]]) {
            
            // frame
            CGRect titleLabelFrame = titleLabel.frame;
            titleLabelFrame.origin.x = (idx * (kIPad ? 240 : 100)) - xOffset / 3.2;
            titleLabel.frame = titleLabelFrame;
            
            // alpha
            CGFloat alpha;
            if(xOffset < normalWidth * idx) {
                alpha = (xOffset - normalWidth * (idx - 1)) / normalWidth;
            }else{
                alpha = 1 - ((xOffset - normalWidth * idx) / normalWidth);
            }
            titleLabel.alpha = alpha;
            
        }
    }];

}

- (DDPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[DDPageControl alloc] init];
        _pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _pageControl.frame = CGRectMake(60, 7, _pageControl.frame.size.width, _pageControl.frame.size.height);
        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPage = self.currentPage;
    }
    return _pageControl;
}

- (NSMutableArray *)titleLabels {
    if (!_titleLabels) {
        _titleLabels = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _titleLabels;
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)dealloc {
    self.pageControl = nil;
    self.titleLabels = nil;
}

@end

