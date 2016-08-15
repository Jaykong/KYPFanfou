//
//  Service+User.h
//  KYPFanfou
//
//  Created by trainer on 8/11/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service.h"

@interface Service (User)
- (void)userShowRequestWithUserID:(NSString *)userID sucess:(void(^)(id result))sucess failure:(void (^)(NSError *error))failure;
@end
