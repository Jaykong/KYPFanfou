//
//  Service+Discover.h
//  KYPFanfou
//
//  Created by JayKong on 8/10/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service.h"

@interface Service (Discover)
- (void)requestTrendsSucess:(void(^)(id result))sucess failure:(void (^)(NSError *error))failure;
//搜索
- (void)searchStatusesWithQuery:(NSString *)query sucess:(void(^)(id result))sucess failure:(void (^)(NSError *error))failure;
@end
