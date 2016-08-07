//
//  CoreDataStack+User.m
//  KYPFanfou
//
//  Created by trainer on 7/26/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataStack+User.h"
#import "User.h"
#import "CoreDataStack+Common.h"
#import "EntityNameConstant.h"
@implementation CoreDataStack (User)
@dynamic currentUser;

-(User *)currentUser {
    User *user = (User *)[self findUniqueEntityWithUniqueKey:@"isActive" value:@YES entityName:USER_ENTITY];
    return user;
}
//根据用户id查找用户数据
- (User *)findUserWithId:(NSString *)uid {
    User *user = (User *)[self findUniqueEntityWithUniqueKey:@"uid" value:uid entityName:USER_ENTITY];
    return user;
}

//插入或更新用户数据
-(User *)insertOrUpdateWithUserProfile:(NSDictionary *)userProfile token:(NSString *)token tokenSecret:(NSString *)tokenSecret {
    //检查数据库是否已知有该条数据再插入
    //数据没有则插入一条数据，有则更新这条数据
    User *user = (User *)[self findUniqueEntityWithUniqueKey:@"uid" value:userProfile[@"id"] entityName:USER_ENTITY];
    if (!user) {
    //插入
        user = [NSEntityDescription insertNewObjectForEntityForName:USER_ENTITY inManagedObjectContext:self.context];
    }
    //更新
    user.name = userProfile[@"name"];
    user.uid = userProfile[@"id"];
    user.iconURL = userProfile[@"profile_image_url"];
    //请求home time api
    //1. status 插入
    //2. user 插入
    if (token) {
        user.token = token;
    }
    if (tokenSecret) {
        user.tokenSecret = tokenSecret;
    }
    // NSLog(@"%@",user.token);
    // NSLog(@"%@",user.tokenSecret);
    return user;
}

@end
