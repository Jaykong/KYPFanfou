//
//  TimelineCell.h
//  KYPFanfou
//
//  Created by trainer on 7/28/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;
@class CellToolbar;
@class TimelineCell;
@class DTAttributedLabel;
typedef void (^DidSelectPhotoBlock)(TimelineCell *cell);

@interface TimelineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateCreatedLbl;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *contentsLbl;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;
@property (weak, nonatomic) IBOutlet CellToolbar *toolbar;
@property (weak, nonatomic) CellToolbar *cellToolbar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentsLblHeightConstraint;
@property (nonatomic,strong) DidSelectPhotoBlock didSelectPhotoBlock;
- (void)configureWithStatus:(Status *)status;


@end
