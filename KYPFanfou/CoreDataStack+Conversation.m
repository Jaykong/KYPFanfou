//
//  CoreDataStack+Conversation.m
//  KYPFanfou
//
//  Created by trainer on 8/5/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataStack+Conversation.h"
#import "Conversation.h"
#import "CoreDataStack+Common.h"
#import "EntityNameConstant.h"
#import "CoreDataStack+Message.h"

@implementation CoreDataStack (Conversation)
//插入单条Conversation数据的方法
/**
 服务器返回的是一个数组
 */
- (Conversation *)insertOrUpdateConversationWithProfile:(NSDictionary *)profile {
    /**
     conversation_list接口返回的数据，区别于conversation接口
     */
    NSString *otherid = profile[@"otherid"];
    NSString *msg_num = profile[@"msg_num"];
    NSString *new_conv = profile[@"new_conv"];
    //message 字典
    NSDictionary *messProfile = profile[@"dm"];
    
    Conversation *conversation = (Conversation *)[self findUniqueEntityWithUniqueKey:@"otherid" value:otherid entityName:CONVERSATION_ENTITY];
    if (!conversation) {
        //插入
        conversation = [NSEntityDescription insertNewObjectForEntityForName:CONVERSATION_ENTITY inManagedObjectContext:self.context];
    }
    //更新
    conversation.otherid = otherid;
    //NSString 转成 NSNumber(int)
    conversation.msg_num = @(msg_num.integerValue);
    //NSString 转成 NSNumber(bool)
    conversation.new_conv = @(new_conv.boolValue);
    
    //插入Message
    Message *mg = [self insertOrUpdateMessageWithProfile:messProfile];
    
    //建立关系
    conversation.message = mg;
    
    return conversation;
    
}
/**
 接口是conversation_list
 接口返回的类型:NSArray数组
 数组的元素：字典
 选把返回字典先插入到数据库 由上面(insertOrUpdateConversationWithProfile)

把数组里面的每个字典用遍历方法全部插入到数据库
 */
- (void)addConversationsWithArrayProfile:(NSArray *)profile {
    //同步插入
    [self.context performBlockAndWait:^{
        [profile enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            [self insertOrUpdateConversationWithProfile:dic];
        }];
    }];
}

@end
