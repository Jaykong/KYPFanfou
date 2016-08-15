//
//  Service+Account.m
//  KYPFanfou
//
//  Created by JayKong on 8/9/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service+Account.h"
#import "APIContant.h"

@implementation Service (Account)
//返回的user/show是未更新的图片链接，你需要从新请求user/show接口来更新自己头像
- (void)postProfileImage:(UIImage *)image  success:(void(^)(id result))success failure:(void(^)(NSError *error))failure{
    NSData *data = UIImageJPEGRepresentation(image, 0.01);
    [self postPhotoWithPath:API_UPDATE_PROFILE_IMAGE parameters:nil sucess:success failure:failure imageData:data fileName:@"image"];
}

//更新用户资料（文本）
//通过 API 更新用户资料
- (void)updateProfileWithLocation:(NSString *)location description:(NSString *)description success:(void(^)(id result))success failure:(void(^)(NSError *error))failure {
    //构造parameters
    NSDictionary *parameters = @{@"location":location,@"description":description};
    [self requestWithPath:API_UPDATE_PROFILE parameters:parameters requestMethod:@"POST" sucess:success failure:failure];
}
@end
