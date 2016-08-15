//
//  Service.h
//  KYPFanfou
//
//  Created by trainer on 7/27/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service : NSObject
+(instancetype)sharedInstance;
//XAuth授权
- (void)authoriseWithUserName:(NSString *)userName password:(NSString *)password success:(void (^)(NSString *token,NSString *tokenSecret))sucess;

//请求用户数据
- (void)requestVerifyCredential:(NSDictionary *)parameters accessToken:(NSString *)accessToken tokenSecret:(NSString *)tokenSecret requestMethod:(NSString *)requestMethod sucess:(void (^)(NSDictionary *result))sucess;

//重构base request 方法，把和access token有关的参数把到方法内部
- (void)requestWithPath:(NSString *)path parameters:(NSDictionary *)parameters requestMethod:(NSString *)requestMethod sucess:(void (^)(id result))sucess failure:(void (^)(NSError *error))failure;
//请求home time line接口的数据，首页加载的数据
- (void)requestStatusWithSucess:(void (^)(NSArray *result))sucess failure:(void (^)(NSError *error))failure;

//发饭的接口，包括文本、图片
- (void)postData:(NSString *)text imageData:(NSData *)imageData replyToStatusID:(NSString *)replyToStatusID repostStatusID:(NSString *)repostStatusID sucess:(void (^)(NSArray *result))sucess failure:(void (^)(NSError *error))failure ;
// 收藏
- (void)starWithStatusID:(NSString *)statusID sucess:(void(^)(id result))sucess failure:(void (^)(NSError *error))failure;

//post photo 用于上传图片和更新头像
- (void)postPhotoWithPath:(NSString *)path parameters:(NSDictionary *)parameters sucess:(void (^)(NSArray *result))sucess failure:(void (^)(NSError *error))failure imageData:(NSData *)imageData fileName:(NSString *)fileName;
@end
