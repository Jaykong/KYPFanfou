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
@class DTLinkButton;
typedef void (^DidSelectPhotoBlock)(TimelineCell *cell);

@protocol TimelineCellDelegate <NSObject>
//when link button is pressed
//当点击文字链接时
- (void)didTouchupLinkButton:(DTLinkButton *)button timelineCell:(TimelineCell *)timelineCell;

@end

@interface TimelineCell : UITableViewCell

@property (nonatomic,weak) id<TimelineCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateCreatedLbl;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *contentsLbl;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;
@property (weak, nonatomic) IBOutlet CellToolbar *toolbar;
@property (weak, nonatomic) CellToolbar *cellToolbar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentsLblHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (nonatomic,strong) DidSelectPhotoBlock didSelectPhotoBlock;
- (void)configureWithStatus:(Status *)status;


@end
