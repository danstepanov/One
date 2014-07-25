//
//  OneTableViewCell.h
//  One
//
//  Created by Micah Benn on 7/17/14.
//
//

#import <UIKit/UIKit.h>
#import "AGMedallionView.h"

typedef enum {
    kServiceTypeFacebook = 0,
    kServiceTypeTwitter,
    kServiceTypeInstagram
    } kServiceType;

@interface OneTableViewCell : UITableViewCell{
    IBOutlet AGMedallionView *avatarImageView;
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *usernameLabel;
    IBOutlet UITextView *textView;
    IBOutlet UILabel *serviceLabel;
}

/**
 Sets the avatar of the cell.
 */
@property (nonatomic,retain) UIImage *avatar;

/**
 Sets the text of the cell.
 */
@property (nonatomic,retain) NSString *text;

/**
 Sets the duration label of the cell.
 */
@property (nonatomic,retain) NSString *time;

/**
 Sets the username of the cell.
 */
@property (nonatomic,retain) NSString *username;

/**
 Sets the service type of the cell.
 */
@property (nonatomic) kServiceType serviceType;

@end
