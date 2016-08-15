//
//  Service+Friendship.m
//  KYPFanfou
//
//  Created by trainer on 8/12/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service+Friendship.h"
#import "APIContant.h"
#import "CoreDataStack+User.h"
@implementation Service (Friendship)
- (void)followUser:(NSString *)userID success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
    NSDictionary *parameters = @{@"id":userID};
    [self requestWithPath:API_FRIENDSHIPS_CREATE parameters:parameters requestMethod:@"POST" sucess:^(id result) {
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateWithUserProfile:result token:nil tokenSecret:nil];
        success(result);
    } failure:failure];

}

- (void)unfollowUser:(NSString *)userID success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
    NSDictionary *parameters = @{@"id":userID};
    [self requestWithPath:API_FRIENDSHIPS_DESTROY parameters:parameters requestMethod:@"POST" sucess:^(id result) {
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateWithUserProfile:result token:nil tokenSecret:nil];
        success(result);
    } failure:failure];

}
@end
