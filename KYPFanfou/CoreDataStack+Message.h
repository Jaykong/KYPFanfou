//
//  CoreDataStack+Message.h
//  KYPFanfou
//
//  Created by trainer on 8/5/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataStack.h"
/**
 私信的数据库操作
 */
@class Message;
@interface CoreDataStack (Message)
- (Message *)insertOrUpdateMessageWithProfile:(NSDictionary *)profile;
- (void)addMessagesWithArrayProfile:(NSArray *)profile;
- (NSArray *)fetchMessagesWithUserID:(NSString *)userID;
@end
