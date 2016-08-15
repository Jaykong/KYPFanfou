//
//  Service+Status.h
//  KYPFanfou
//
//  Created by trainer on 8/12/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service.h"

@interface Service (Status)
- (void)user_timelineWithUserID:(NSString *)userID sucess:(void(^)(id result))sucess failure:(void (^)(NSError *error))failure;
@end
