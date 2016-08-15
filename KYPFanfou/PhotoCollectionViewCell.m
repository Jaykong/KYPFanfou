//
//  PhotoCollectionViewCell.m
//  KYPFanfou
//
//  Created by JayKong on 8/9/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "Status.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Photo.h"
@implementation PhotoCollectionViewCell

- (void)configureCellWithStatus:(Status *)status {
    NSURL *photoURL = [NSURL URLWithString:status.photo.thumburl];
    [_photoImageview sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"BackgroundAvatar"] options:SDWebImageProgressiveDownload];
}
@end
