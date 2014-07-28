//
//  Formerly XHTwitterPaggingViewer.m
//  XHTwitterPagging
//
//  Created by 曾 宪华 on 14-6-20.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "OneSocialPagingViewer.h"
#import "OnePagingNavBar.h"
#import "AGMedallionView.h"

typedef NS_ENUM(NSInteger, XHSlideType) {
    XHSlideTypeLeft = 0,
    XHSlideTypeRight = 1,
};

static UIBarButtonItem *composeButton;
static AGMedallionView *avatarView;

@interface OneSocialPagingViewer () <UIScrollViewDelegate>

@end

@implementation OneSocialPagingViewer

#pragma mark - DataSource

- (NSInteger)getCurrentPageIndex {
    return self.currentPage;
}

- (void)reloadData {
    if (!self.viewControllers.count) {
        return;
    }
    
	[self.paggingScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        CGRect contentViewFrame = viewController.view.bounds;
        contentViewFrame.origin.x = idx * CGRectGetWidth(self.view.bounds);
        viewController.view.frame = contentViewFrame;
        [self.paggingScrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
    
    [self.paggingScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds) * self.viewControllers.count, 0)];
    
    self.paggingNavbar.titles = [self.viewControllers valueForKey:@"title"];
    [self.paggingNavbar reloadData];
    
    [self setupScrollToTop];
    
    [self callBackChangedPage];
}

#pragma mark - Propertys

- (UIView *)centerContainerView {
    if (!_centerContainerView) {
        _centerContainerView = [[UIView alloc] initWithFrame:CGRectZero];
		CGFloat y = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
		[_centerContainerView setFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - (y + 20 + 49))];
		[_centerContainerView setHidden:YES];
        _centerContainerView.backgroundColor = [UIColor whiteColor];
        
        [_centerContainerView addSubview:self.paggingScrollView];
        [self.paggingScrollView.panGestureRecognizer addTarget:self action:@selector(panGestureRecognizerHandle:)];
    }
    return _centerContainerView;
}

- (UIScrollView *)paggingScrollView {
    if (!_paggingScrollView) {
        _paggingScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _paggingScrollView.bounces = NO;
        _paggingScrollView.pagingEnabled = YES;
        [_paggingScrollView setScrollsToTop:NO];
        _paggingScrollView.delegate = self;
        _paggingScrollView.showsVerticalScrollIndicator = NO;
        _paggingScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _paggingScrollView;
}

- (OnePagingNavBar *)paggingNavbar {
    if (!_paggingNavbar) {
        _paggingNavbar = [[OnePagingNavBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) / 2.0, 44)];
        _paggingNavbar.backgroundColor = [UIColor clearColor];
    }
    return _paggingNavbar;
}

- (UIViewController *)getPageViewControllerAtIndex:(NSInteger)index {
    if (index < self.viewControllers.count) {
        return self.viewControllers[index];
    } else {
        return nil;
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (_currentPage == currentPage)
        return;
    _currentPage = currentPage;
    
    self.paggingNavbar.currentPage = currentPage;
    
    [self setupScrollToTop];
    [self callBackChangedPage];
}

#pragma mark - Life Cycle

- (void)setupTargetViewController:(UIViewController *)targetViewController withSlideType:(XHSlideType)slideType {
    if (!targetViewController)
        return;
    
    [self addChildViewController:targetViewController];
    CGRect targetViewFrame = targetViewController.view.frame;
    switch (slideType) {
        case XHSlideTypeLeft: {
            targetViewFrame.origin.x = -CGRectGetWidth(self.view.bounds);
            break;
        }
        case XHSlideTypeRight: {
            targetViewFrame.origin.x = CGRectGetWidth(self.view.bounds) * 2;
            break;
        }
        default:
            break;
    }
    targetViewController.view.frame = targetViewFrame;
    [self.view insertSubview:targetViewController.view atIndex:0];
    [targetViewController didMoveToParentViewController:self];
}

- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController {
    return [self initWithLeftViewController:leftViewController rightViewController:nil];
}

- (instancetype)initWithRightViewController:(UIViewController *)rightViewController {
    return [self initWithLeftViewController:nil rightViewController:rightViewController];
}

- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController rightViewController:(UIViewController *)rightViewController {
    self = [super init];
    if (self) {
        self.leftViewController = leftViewController;
        
        self.rightViewController = rightViewController;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupViews];
    [self reloadData];
    
    //Add the 'compose' button.
    composeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:0];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor flatLightBlueColor];
    self.navigationItem.rightBarButtonItem = composeButton;
    [self.navigationController setNavigationBarHidden:NO];
    //Add the user avatar view.
    avatarView = [[AGMedallionView alloc] initWithFrame:CGRectMake(7, 5, 35, 35)];
    avatarView.image = [UIImage imageNamed:@"Avatar.png"];
    [self.navigationController.navigationBar addSubview:avatarView];
}

- (void)setupNavigationBar {
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
        
        [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              [UIColor blackColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
        
    } else {
        
        
    }
    
    self.navigationItem.titleView = self.paggingNavbar;
}

- (void)setupViews {
    [self.view addSubview:self.centerContainerView];
    
    [self setupTargetViewController:self.leftViewController withSlideType:XHSlideTypeLeft];
    [self setupTargetViewController:self.rightViewController withSlideType:XHSlideTypeRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.paggingScrollView.delegate = nil;
    self.paggingScrollView = nil;
    
    self.paggingNavbar = nil;
    
    self.viewControllers = nil;
    
    self.didChangedPageCompleted = nil;
}

#pragma mark - PanGesture Handle Method

- (void)panGestureRecognizerHandle:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint contentOffset = self.paggingScrollView.contentOffset;
    
    CGSize contentSize = self.paggingScrollView.contentSize;
    
    CGFloat baseWidth = CGRectGetWidth(self.paggingScrollView.bounds);
    
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged: {
            
            if (contentOffset.x <= 0) {
                [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
            } else if (contentOffset.x >= contentSize.width - baseWidth) {
                [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
            }
            
            break;
        }
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            break;
        }
        default:
            break;
    }
}

#pragma mark - Block Call Back Method

- (void)callBackChangedPage {
    if (self.didChangedPageCompleted) {
        self.didChangedPageCompleted(self.currentPage, [[self.viewControllers valueForKey:@"title"] objectAtIndex:self.currentPage]);
    }
}

#pragma mark - TableView Helper Method

- (void)setupScrollToTop {
    for (int i = 0; i < self.viewControllers.count; i ++) {
        UITableView *tableView = (UITableView *)[self subviewWithClass:[UITableView class] onView:[self getPageViewControllerAtIndex:i].view];
        if (tableView) {
            if (self.currentPage == i) {
                [tableView setScrollsToTop:YES];
            } else {
                [tableView setScrollsToTop:NO];
            }
        }
    }
}

#pragma mark - View Helper Method

- (UIView *)subviewWithClass:(Class)cuurentClass onView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:cuurentClass]) {
            return subView;
        }
    }
    return nil;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.paggingNavbar.contentOffset = scrollView.contentOffset;
    
    CGFloat offset = scrollView.contentOffset.x+scrollView.contentInset.right;
    CGFloat startLoadingThreshold = 320.0;
    CGFloat fractionDragged       = offset/startLoadingThreshold;
        
    if (fractionDragged == 0.0 || fractionDragged == 1.0 || fractionDragged == 2.0 || fractionDragged == 3.0) {
        [self chageColorWithTitle:[self.paggingNavbar.titles objectAtIndex:fractionDragged]];
    }
    
    [self.paggingNavbar percentSwiped:fractionDragged];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    CGFloat pageWidth = scrollView.frame.size.width;
    
    self.currentPage = floor((scrollView.contentOffset.x - pageWidth/ 2) / pageWidth)+ 1;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    NSInteger newCurrentPage;
    
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x > 0) {
        // handle dragging to the right
        newCurrentPage = self.currentPage - 1;
        
        if (newCurrentPage == -1){
            newCurrentPage = 0;
        }else{
            [self chageColorWithTitle:[self.paggingNavbar.titles objectAtIndex:newCurrentPage]];
        }
        
    } else {
        // handle dragging to the left
        newCurrentPage = self.currentPage + 1;
        
        if (newCurrentPage == 4){
            newCurrentPage = 3;
        }else{
           [self chageColorWithTitle:[self.paggingNavbar.titles objectAtIndex:newCurrentPage]];
        }
    
    }
    
}

- (void)chageColorWithTitle:(NSString*)title{
    
    UIColor *navBarColor;
    UIColor *navBarTintColor;
    
    if ([title isEqualToString:@"Timeline"]){
        navBarColor = [UIColor whiteColor];
    }else if ([title isEqualToString:@"Facebook"]){
        navBarColor= [UIColor facebookNavBarColor];
    }else if ([title isEqualToString:@"Twitter"]){
        navBarColor = [UIColor twitterNavBarColor];
    }else if ([title isEqualToString:@"Instagram"]){
        navBarColor = [UIColor instagramNavBarColor];
    }else{
        navBarColor = [UIColor whiteColor];
    }
    
    if (![title isEqualToString:@"Timeline"]){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        navBarTintColor = [UIColor whiteColor];
        
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        navBarTintColor = [UIColor flatLightBlueColor];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.navigationController.navigationBar.barTintColor = navBarColor;
        composeButton.tintColor = navBarTintColor;
    }];
    
}

@end