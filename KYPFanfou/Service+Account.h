//
//  Service+Account.h
//  KYPFanfou
//
//  Created by JayKong on 8/9/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service.h"
#import <UIKit/UIKit.h>
@interface Service (Account)
//上传头像
- (void)postProfileImage:(UIImage *)image success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;
//更新用户资料
- (void)updateProfileWithLocation:(NSString *)location description:(NSString *)description success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;
@end
