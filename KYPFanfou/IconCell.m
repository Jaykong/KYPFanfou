//
//  IconCell.m
//  KYPFanfou
//
//  Created by JayKong on 8/10/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "IconCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CoreDataStack+User.h"
#import "User.h"

@interface IconCell ()
@property (strong,nonatomic) CapturePhotoBlock capturePhotoBlock;
@end

@implementation IconCell

- (void)awakeFromNib {
    [super awakeFromNib];
    User *user = [CoreDataStack sharedCoreDataStack].currentUser;
    NSURL *url = [NSURL URLWithString:user.iconURL];
    [_iconImageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)capturePhotoWithBlock:(CapturePhotoBlock)capturePhotoBlock {
    _capturePhotoBlock = capturePhotoBlock;
}
//点击头像
- (IBAction)updateIconImage:(id)sender {
    NSLog(@"%s",__func__);
    _capturePhotoBlock(self,sender);
}


@end
