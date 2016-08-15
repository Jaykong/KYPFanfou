//
//  Service+Status.m
//  KYPFanfou
//
//  Created by trainer on 8/12/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service+Status.h"
#import "APIContant.h"
@implementation Service (Status)
- (void)user_timelineWithUserID:(NSString *)userID sucess:(void(^)(id result))sucess failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{@"id":userID};
    [self requestWithPath:API_STATUSES_USER_TIMELINE parameters:parameters requestMethod:@"GET" sucess:sucess failure:failure];
}
@end
