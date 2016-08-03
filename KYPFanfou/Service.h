//
//  Service.h
//  KYPFanfou
//
//  Created by trainer on 7/27/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service : NSObject
- (void)authoriseWithUserName:(NSString *)userName password:(NSString *)password success:(void (^)(NSString *token,NSString *tokenSecret))sucess;
+(instancetype)sharedInstance;
- (void)requestVerifyCredential:(NSDictionary *)parameters accessToken:(NSString *)accessToken tokenSecret:(NSString *)tokenSecret requestMethod:(NSString *)requestMethod sucess:(void (^)(NSDictionary *result))sucess;
- (void)requestStatusWithSucess:(void (^)(NSArray *result))sucess failure:(void (^)(NSError *error))failure ;


- (void)postData:(NSString *)text imageData:(NSData *)imageData replyToStatusID:(NSString *)replyToStatusID repostStatusID:(NSString *)repostStatusID sucess:(void (^)(NSArray *result))sucess failure:(void (^)(NSError *error))failure ;
@end
