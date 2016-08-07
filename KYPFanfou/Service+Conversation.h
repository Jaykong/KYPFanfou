//
//  Service+Conversation.h
//  KYPFanfou
//
//  Created by trainer on 8/5/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service.h"

@interface Service (Conversation)
- (void)conversationListSucess:(void(^)(NSArray *))sucess failure:(void (^)(NSError *error))failure;
- (void)conversationsWithUserID:(NSString *)userID sucess:(void(^)(NSArray *))sucess failure:(void (^)(NSError *error))failure;
- (void)postMessageWithUserID:(NSString *)userID text:(NSString *)text  sucess:(void(^)(NSArray *))sucess inReplyID:(NSString *)inReplyID failure:(void (^)(NSError *error))failure;
@end
