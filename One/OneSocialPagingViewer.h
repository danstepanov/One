//
//  Formerly XHTwitterPaggingViewer.h
//  XHTwitterPagging
//
//  Created by 曾 宪华 on 14-6-20.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnePagingNavBar.h"

typedef void(^XHDidChangedPageBlock)(NSInteger currentPage, NSString *title);

@interface OneSocialPagingViewer : UIViewController

@property (nonatomic, copy) XHDidChangedPageBlock didChangedPageCompleted;

@property (nonatomic, strong) NSArray *viewControllers;

@property (nonatomic, strong) UIView *centerContainerView;

@property (nonatomic, strong) UIScrollView *paggingScrollView;

@property (nonatomic, strong) OnePagingNavBar *paggingNavbar;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) UIViewController *rightViewController;
- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController;

- (instancetype)initWithRightViewController:(UIViewController *)rightViewController;

- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController rightViewController:(UIViewController *)rightViewController;

- (NSInteger)getCurrentPageIndex;

- (void)reloadData;

@end
