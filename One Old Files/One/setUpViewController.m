//
//  setUpViewController.m
//  One
//
//  Created by Daniel Stepanov on 7/16/14.
//  Copyright (c) 2014 One. All rights reserved.
//

#import "setUpViewController.h"


@implementation setUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    //configure swipe view
//    _swipeView.alignment = SwipeViewAlignmentCenter;
//    _swipeView.pagingEnabled = YES;
//    _swipeView.itemsPerPage = 1;
//    _swipeView.truncateFinalPage = YES;
}

- (void)dealloc
{
//    _swipeView.delegate = nil;
//    _swipeView.dataSource = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

//- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
//{
//    //generate 100 item views
//    //normally we'd use a backing array
//    //as shown in the basic iOS example
//    //but for this example we haven't bothered
//    return 3;
//}

//- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
//{
//    if (!view)
//    {
//    	//load new item view instance from nib
//        //control events are bound to view controller in nib file
//        //note that it is only safe to use the reusingView if we return the same nib for each
//        //item view, if different items have different contents, ignore the reusingView value
//        
//    	// NSLog(@"%@", [[NSBundle mainBundle] loadNibNamed:@"Tutorial1View" owner:swipeView options:nil]);
//    }
//    return view;
//}

#pragma mark -
#pragma mark Control events

@end