//
//  TimelineCell.m
//  KYPFanfou
//
//  Created by trainer on 7/28/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "TimelineCell.h"
#import "Status.h"
#import "User.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation TimelineCell

- (void)configureWithStatus:(Status *)status; {
    self.nameLabel.text = status.user.name;
    //self.idLabel.text = status.user.uid;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    self.dateCreatedLbl.text = [formatter stringFromDate:status.created_at ];
    NSURL *url = [NSURL URLWithString:status.user.iconURL];
    self.contentsLbl.text = status.text;
    [self.iconImageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached];
}
@end
