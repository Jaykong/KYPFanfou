//
//  IconCell.h
//  KYPFanfou
//
//  Created by JayKong on 8/10/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IconCell;
typedef void (^CapturePhotoBlock)(IconCell *cell,UIButton *btn);
@interface IconCell : UITableViewCell
@property (strong,nonatomic) IBOutlet UIImageView *iconImageView;
- (void)capturePhotoWithBlock:(CapturePhotoBlock)capturePhotoBlock;
@end
