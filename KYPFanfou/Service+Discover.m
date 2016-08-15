//
//  Service+Discover.m
//  KYPFanfou
//
//  Created by JayKong on 8/10/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service+Discover.h"
#import "APIContant.h"
@implementation Service (Discover)
- (void)requestTrendsSucess:(void(^)(id result))sucess failure:(void (^)(NSError *error))failure {
    [self requestWithPath:API_TRENDS_LIST parameters:nil requestMethod:@"GET" sucess:sucess failure:failure];
}

//搜索
- (void)searchStatusesWithQuery:(NSString *)query sucess:(void(^)(id result))sucess failure:(void (^)(NSError *error))failure{
    //{@"mode":@"lite",@"count":@60,@"format":@"html"}
    NSDictionary *parameters = @{@"q":query,@"format":@"html"};
    [self requestWithPath:API_SEARCH_PUBLIC_TIMELINE parameters:parameters requestMethod:@"GET" sucess:sucess failure:failure];
}
@end
