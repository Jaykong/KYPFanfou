//
//  Service+User.m
//  KYPFanfou
//
//  Created by trainer on 8/11/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service+User.h"
#import "APIContant.h"
@implementation Service (User)
- (void)userShowRequestWithUserID:(NSString *)userID sucess:(void(^)(id result))sucess failure:(void (^)(NSError *error))failure{
    NSDictionary *parameters = @{@"id":userID,@"mode":@"lite"};
    [self requestWithPath:API_USERS_SHOW parameters:parameters requestMethod:@"GET" sucess:sucess failure:failure];
}
@end
