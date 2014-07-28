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
#import "CAGradientLayer+OneGradientLayer.h"

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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
	if (expandedPath && ([indexPath compare:expandedPath] == NSOrderedSame)) {
		NSArray *buttons = nil;
		switch (cell.serviceType) {
			case kServiceTypeFacebook: {
				PFXSocialButton *like = [[PFXSocialButton alloc] init];
				like.label.text = @"Like";
				PFXSocialButton *comment = [[PFXSocialButton alloc] init];
				comment.label.text = @"Comment";
				buttons = @[like, comment];
				break;
			}
			case kServiceTypeInstagram: {
				PFXSocialButton *like = [[PFXSocialButton alloc] init];
				like.label.text = @"Like";
				PFXSocialButton *comment = [[PFXSocialButton alloc] init];
				comment.label.text = @"Comment";
				buttons = @[like, comment];
				break;
			}
			case kServiceTypeTwitter: {
				PFXSocialButton *reply = [[PFXSocialButton alloc] init];
				reply.label.text = @"Reply";
				PFXSocialButton *fav = [[PFXSocialButton alloc] init];
				fav.label.text = @"Favorite";
				PFXSocialButton *rt = [[PFXSocialButton alloc] init];
				rt.label.text = @"Retweet";
				buttons = @[reply, fav, rt];
				break;
			}
			default:
				break;
		}
		UIView *temp = [UIView new];
		[temp setTag:1222];
		CGFloat width = self.view.frame.size.width / [buttons count];
		for (int i = 0; i < [buttons count]; i++) {
			UIView *v = buttons[i];
			[v setFrame:CGRectMake(i*width, 0, width, 10)];
			[temp addSubview:v];
		}
		[temp setFrame:CGRectMake(0, cell.frame.size.height-10, cell.frame.size.width, 10)];
		[cell addSubview:temp];
	}
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (expandedPath) {
		if ([indexPath compare:expandedPath] == NSOrderedSame) {
			return 125 + 10;
		}
	}
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath && ([indexPath compare:expandedPath] == NSOrderedSame)) {
		expandedPath = NULL;
		OneTableViewCell *cell = (OneTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
		switch (cell.serviceType) {
			case kServiceTypeFacebook:
				cell.serviceLabel.textColor = [UIColor facebookNavBarColor];
				break;
			case kServiceTypeInstagram:
				cell.serviceLabel.textColor = [UIColor instagramNavBarColor];
				break;
			case kServiceTypeTwitter:
				cell.serviceLabel.textColor = [UIColor twitterNavBarColor];
				break;
		}
		cell.timeLabel.textColor = [UIColor blackColor];
		cell.textView.textColor = [UIColor blackColor];
		cell.usernameLabel.textColor = [UIColor blackColor];
		[UIView animateWithDuration:.25 animations:^ {
			[[cell viewWithTag:188881] setAlpha:0.0];
			[[cell viewWithTag:1222] setAlpha:0.0];
		} completion:^(BOOL fin) {
			[[cell viewWithTag:188881] removeFromSuperview];
			[[cell viewWithTag:1222] removeFromSuperview];
		}];
	}
	else {
		expandedPath = indexPath;
		[tableView beginUpdates];
		[tableView endUpdates];
		CAGradientLayer *gradient = nil;
		OneTableViewCell *cell = (OneTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
		switch (cell.serviceType) {
			case kServiceTypeFacebook:
					gradient = [CAGradientLayer facebookGradientLayer];
				break;
			case kServiceTypeInstagram:
				gradient = [CAGradientLayer instagramGradientLayer];
				break;
			case kServiceTypeTwitter:
				gradient = [CAGradientLayer twitterGradientLayer];
				break;
			default:
				break;
		}
		UIView *fakeView = [[UIView alloc] init];
		[fakeView setFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height + 50)];
		[fakeView.layer addSublayer:gradient];
		[gradient setFrame:fakeView.frame];
		[fakeView setTag:188881];
		[fakeView setAlpha:0.0];
		[cell addSubview:fakeView];
		[cell sendSubviewToBack:fakeView];
		[UIView beginAnimations:nil context:nil];
		cell.usernameLabel.textColor = [UIColor whiteColor];
		cell.serviceLabel.textColor = [UIColor lightGrayColor];
		cell.timeLabel.textColor = [UIColor whiteColor];
		cell.textView.textColor = [UIColor whiteColor];
		[fakeView setAlpha:1.0];
		[UIView commitAnimations];
	}

	
	/*
	 TimelineViewController *detailTableViewController = [[[self class] alloc] init];
	 detailTableViewController.showPushDetail = YES;
	 detailTableViewController.title = @"Post";
	 [self.navigationController pushViewController:detailTableViewController animated:YES];
	 */
}

@end
