//
//  UserHeaderView.h
//  KYPFanfou
//
//  Created by JayKong on 8/8/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ARSegmentPager/ARSegmentPageControllerHeaderProtocol.h>
@class UserHeaderView;
@class User;
typedef void (^UpdateAccountProfile)(UserHeaderView *headerView,UIButton *sender);


@interface UserHeaderView : UIView<ARSegmentPageControllerHeaderProtocol>
@property (nonatomic) UIImageView *imageView;

- (void)updateProfileWithBlock:(UpdateAccountProfile)updateAccountProfile;
- (void)configureViewWithUser:(User *)user;
@end
