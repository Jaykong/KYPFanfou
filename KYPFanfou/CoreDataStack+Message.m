//
//  CoreDataStack+Message.m
//  KYPFanfou
//
//  Created by trainer on 8/5/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataStack+Message.h"
#import "Message.h"
#import "CoreDataStack+Common.h"
#import "EntityNameConstant.h"
#import "CoreDataStack+User.h"
#import "User.h"
@implementation CoreDataStack (Message)
- (Message *)insertOrUpdateMessageWithProfile:(NSDictionary *)profile {
    /**
     conversation-list返回的字典包含的内容
     */
    NSString *mid = profile[@"id"];
    NSString *text = profile[@"text"];
    NSString *sender_id = profile[@"sender_id"];
    NSString *recipient_id = profile[@"recipient_id"];
    NSString *created_at = profile[@"created_at"];
    NSString *sender_screen_name = profile[@"sender_screen_name"];
    NSString *recipient_screen_name = profile[@"recipient_screen_name"];
    
    //用户字典
    NSDictionary *senderProfile = profile[@"sender"];
    NSDictionary *recipientProfile = profile[@"recipient"];
    
    //profile对应是接口哪个部分？
    //conversation-list返回的字典中键值dm所对应的值（字典）
    //检查数据库里有没有？
    Message *mg = (Message *)[self findUniqueEntityWithUniqueKey:@"mid" value:mid entityName:MESSAGE_ENTITY];
    if (!mg) {
        mg = [NSEntityDescription insertNewObjectForEntityForName:MESSAGE_ENTITY inManagedObjectContext:self.context];
    }
    mg.mid = mid;
    mg.text = text;
    mg.sender_id = sender_id;
    mg.recipient_id = recipient_id;
    mg.created_at = [self dateFromString:created_at];
    mg.sender_screen_name = sender_screen_name;
    mg.recipient_screen_name = recipient_screen_name;
    
    //插入用户表
    User *sender = [self insertOrUpdateWithUserProfile:senderProfile token:nil tokenSecret:nil];
    User *recipient = [self insertOrUpdateWithUserProfile:recipientProfile token:nil tokenSecret:nil];
    mg.sender = sender;
    mg.recipient = recipient;
    return mg;
}

- (void)addMessagesWithArrayProfile:(NSArray *)profile  {
    [profile enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.context performBlockAndWait:^{
            [self insertOrUpdateMessageWithProfile:obj];
            
        }];
        
    }];
    
}
//由于和你对话的人即可以是recipient_id也可以是sender_id
- (NSArray *)fetchMessagesWithUserID:(NSString *)userID {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"recipient_id = %@ OR sender_id = %@",userID,userID];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:YES];
    
    return [self fetchObjectsWithPredicate:pre sortDescriptors:@[descriptor] entityName:MESSAGE_ENTITY];
}

@end
