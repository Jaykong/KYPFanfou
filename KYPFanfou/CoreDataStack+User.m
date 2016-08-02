//
//  CoreDataStack+User.m
//  KYPFanfou
//
//  Created by trainer on 7/26/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataStack+User.h"
#import "User.h"
NSString *const USER_ENTITY = @"User";

@implementation CoreDataStack (User)
@dynamic currentUser;
- (User *)findUniqueEntityWithUniqueID:(NSString *)key value:(id)value {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:USER_ENTITY];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@",key,value];
    fr.predicate = predicate;
    NSError *error;
    NSArray *users = [self.context executeFetchRequest:fr error:&error];
    if (users.count > 0) {
        return users[0];
    }
    return nil;
}

-(User *)currentUser {
    User *user = [self findUniqueEntityWithUniqueID:@"isActive" value:@YES];
    return user;
}
//根据用户id查找用户数据
- (User *)findUserWithId:(NSString *)uid {
    User *user = [self findUniqueEntityWithUniqueID:@"uid" value:uid];
    return user;
}
-(User *)checkImportedWithUserID:(NSString *)uid {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:USER_ENTITY];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid like %@",uid];
    fr.predicate = predicate;
    NSError *error;
    NSArray *users = [self.context executeFetchRequest:fr error:&error];
    if (users.count > 0) {
        return users[0];
    }
    return nil;
}

-(User *)insertOrUpdateWithUserProfile:(NSDictionary *)userProfile token:(NSString *)token tokenSecret:(NSString *)tokenSecret {
    
    User *user =  [self checkImportedWithUserID:userProfile[@"id"]];
    if (!user) {
        user = [NSEntityDescription insertNewObjectForEntityForName:USER_ENTITY inManagedObjectContext:self.context];
    }
    user.name = userProfile[@"name"];
    user.uid = userProfile[@"id"];
    user.iconURL = userProfile[@"profile_image_url"];
    
    user.token = token;
    user.tokenSecret = tokenSecret;
    // NSLog(@"%@",user.token);
    // NSLog(@"%@",user.tokenSecret);
    return user;
}

@end
