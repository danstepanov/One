//
//  ProfileViewController.h
//  One
//
//  Created by Micah Benn on 7/17/14.
//
//

#import <UIKit/UIKit.h>
#import "ALScrollViewPaging.h"

@interface ProfileViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource> {
    UITableView *tableView;
    UICollectionView *collectionView;
    
    ALScrollViewPaging *headerView;
}

- (void)headerDidScrollWithPercent:(CGFloat)percent;
- (void)setBackgroundColor:(UIColor*)color;
    
@end
