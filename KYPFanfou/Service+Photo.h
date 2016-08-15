//
//  Service+Photo.h
//  KYPFanfou
//
//  Created by JayKong on 8/9/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service.h"

@interface Service (Photo)
- (void)getPhotosUserTimelineWithUserID:(NSString *)userID sucess:(void(^)(id result))sucess failure:(void (^)(NSError *error))failure;
@end
