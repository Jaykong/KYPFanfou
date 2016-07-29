//
//  UserTableViewCell.m
//  KYPFanfou
//
//  Created by trainer on 7/26/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "UserTableViewCell.h"
#import "User.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation UserTableViewCell

- (void)configureWithUser:(User *)user; {
    self.nameLabel.text = user.name;
    self.idLabel.text = user.uid;

    NSURL *url = [NSURL URLWithString:user.iconURL];
    [self.iconImageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached];






}


@end
