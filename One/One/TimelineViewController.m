//
//  TimelineViewController.h
//  One
//
//  Created by Micah Benn on 7/17/14.
//
//

#import "TimelineViewController.h"
#import "OnePagingNavBar.h"
#import "OneTableViewCell.h"
#import "AppDelegate.h"

@interface TimelineViewController ()

@end

@implementation TimelineViewController

- (void)loadDataSource {
    self.dataSource = (NSMutableArray *)@[@"Spent 10 hours today painting letters on windows (completely worth it in the end). Will post more pics. #vsco"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    if (!self.showPushDetail) {
        UIEdgeInsets edgeInsets = self.tableView.contentInset;
        edgeInsets.top = ([OneFoundationCommon isIOS7] ? 0 : 0);
        self.tableView.contentInset = edgeInsets;
        self.tableView.scrollIndicatorInsets = edgeInsets;
    }
        
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OneTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(80, cell.frame.size.height, 240, 0.3)];
        separatorView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        separatorView.layer.borderWidth = 0.3;
        [cell.contentView addSubview:separatorView];
    }
    
    cell.username = @"Michael";
    cell.serviceType = kServiceTypeTwitter;
    cell.avatar = [UIImage imageNamed:@"Avatar.png"];
    cell.text = self.dataSource[indexPath.row];
    cell.time = @"1m";
    
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TimelineViewController *detailTableViewController = [[[self class] alloc] init];
    detailTableViewController.showPushDetail = YES;
    detailTableViewController.title = @"Post";
    [self.navigationController pushViewController:detailTableViewController animated:YES];
}

@end
