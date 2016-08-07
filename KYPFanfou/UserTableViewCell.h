//
//  UserTableViewCell.h
//  KYPFanfou
//
//  Created by trainer on 7/26/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  User;
@class Conversation;
@interface UserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
- (void)configureWithConversation:(Conversation *)ct;
- (void)configureWithUser:(User *)user;
@end
