//
//  TimelineCell.h
//  KYPFanfou
//
//  Created by trainer on 7/28/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;
@interface TimelineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateCreatedLbl;

@property (weak, nonatomic) IBOutlet UILabel *contentsLbl;

- (void)configureWithStatus:(Status *)status;

@end
