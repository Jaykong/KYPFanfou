//
//  Service+Friendship.h
//  KYPFanfou
//
//  Created by trainer on 8/12/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service.h"

@interface Service (Friendship)
- (void)followUser:(NSString *)userID success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
- (void)unfollowUser:(NSString *)userID success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
@end
