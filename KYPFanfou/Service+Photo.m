//
//  Service+Photo.m
//  KYPFanfou
//
//  Created by JayKong on 8/9/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service+Photo.h"
#import "APIContant.h"
@implementation Service (Photo)
- (void)getPhotosUserTimelineWithUserID:(NSString *)userID sucess:(void(^)(id result))sucess failure:(void (^)(NSError *error))failure; {
    NSDictionary *parameters = @{@"id":userID};
    [self requestWithPath:API_PHOTOS_TIMELINE parameters:parameters requestMethod:@"GET" sucess:sucess failure:failure];
}
@end
