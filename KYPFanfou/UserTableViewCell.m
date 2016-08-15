//
//  UserTableViewCell.m
//  KYPFanfou
//
//  Created by trainer on 7/26/16.
//  Copyright © 2016 trainer. All rights reserved.
//
#import "Conversation.h"
#import "UserTableViewCell.h"
#import "User.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CoreDataStack+User.h"
@implementation UserTableViewCell

- (void)configureWithUser:(User *)user; {
    self.nameLabel.text = user.name;
    self.idLabel.text = user.uid;
    
    NSURL *url = [NSURL URLWithString:user.iconURL];
    [self.iconImageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached];
}

- (void)configureWithConversation:(Conversation *)ct; {
    //由于显示不同sender和recipient会彼此转换
    //接受消息时sender是与你对话的人
    
    /**
     如果otherid等于当前用户，那是不可能的！
     otherid一定是与你对话的人的用户id
     如果otherid等于sender的user id，则是别人在发送消息给你
     反之亦然
     */
    //    if ([ct.otherid isEqualToString:ct.message.sender.uid]) {
    //        self.nameLabel.text = ct.message.sender_screen_name;
    //        
    //    } else {
    //        self.nameLabel.text = ct.message.recipient_screen_name;
    //    }
    //
    //    NSURL *url;
    //    if ([conversation.otherid isEqualToString:conversation.message.sender.uid]) {
    //        self.nameLabel.text = conversation.message.sender.name;
    //        url = [NSURL URLWithString:conversation.message.sender.iconURL];
    //    } else {
    //        self.nameLabel.text = conversation.message.recipient.name;
    //        url = [NSURL URLWithString:conversation.message.recipient.iconURL];
    //    }
    
    User *user = [[CoreDataStack sharedCoreDataStack] findUserWithId:ct.otherid];
    
    NSURL *url = [NSURL URLWithString:user.iconURL];
    
    self.nameLabel.text = user.name;
    self.idLabel.text = ct.otherid;
    [self.iconImageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached];
    
    
}
@end
