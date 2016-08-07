//
//  Service+Conversation.m
//  KYPFanfou
//
//  Created by trainer on 8/5/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service+Conversation.h"
#import "APIContant.h"
@implementation Service (Conversation)
//API_CONVERSATION_LIST 返回coversation数组
- (void)conversationListSucess:(void(^)(NSArray *))sucess failure:(void (^)(NSError *error))failure {
    [self requestWithPath:API_CONVERSATION_LIST parameters:nil requestMethod:@"GET" sucess:sucess failure:failure];
    
}

- (void)conversationsWithUserID:(NSString *)userID sucess:(void(^)(NSArray *))sucess failure:(void (^)(NSError *error))failure {
    NSDictionary *profile = @{@"id":userID};
    [self requestWithPath:API_CONVERSATION parameters:profile requestMethod:@"GET" sucess:sucess failure:failure];
    
}

- (void)postMessageWithUserID:(NSString *)userID text:(NSString *)text  sucess:(void(^)(NSArray *))sucess inReplyID:(NSString *)inReplyID failure:(void (^)(NSError *error))failure{
    NSDictionary *pf = @{@"user":userID,@"text":text,@"in_reply_to_id":inReplyID};
    NSLog(@"%@",pf);
    [self requestWithPath:API_MESSAGES_NEW parameters:pf requestMethod:@"POST" sucess:sucess failure:failure];
}
@end
