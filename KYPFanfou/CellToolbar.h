//
//  CellToolbar.h
//  KYPFanfou
//
//  Created by JayKong on 7/31/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellToolbar;
@protocol CellToolbarDelegate
@required
//收藏
- (void)starWithCellToolbar:(CellToolbar *)toolbar sender:(id)sender forEvent:(UIEvent *)event;
//转发
- (void)repostWithCellToolbar:(CellToolbar *)toolbar sender:(id)sender forEvent:(UIEvent *)event;
//回复
- (void)replyWithCellToolbar:(CellToolbar *)toolbar sender:(id)sender forEvent:(UIEvent *)event;
@end

@interface CellToolbar : UIView
@property (weak, nonatomic) IBOutlet UIButton *starBtn;
@property (nonatomic,weak) id <CellToolbarDelegate> delegate;

- (void)setupStarButtonWithBool:(Boolean)favorited;

@end
