//
//  CoreDataStack+Status.m
//  KYPFanfou
//
//  Created by JayKong on 7/29/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataStack+Status.h"
#import "Status.h"
#import "User.h"
#import "CoreDataStack+User.h"
#import "Photo.h"
#import "CoreDataStack+Common.h"
static NSString *const STATUS_ENTITY = @"Status";
static NSString *const PHOTO_ENTITY = @"Photo";
@implementation CoreDataStack (Status)
- (void)insertOrUpdateStatusWithObjects:(NSArray *)objects {
    
    [objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // insure the date inserted
        [self.context performBlockAndWait:^{
            [self insertOrUpdateStatusWithStatusProfile:obj];
        }];
    }];
}

- (Status *)insertOrUpdateStatusWithStatusProfile:(NSDictionary *)statusProfile{
    NSString *sid = statusProfile[@"id"];
    Status *status = [self checkImportedWithStatusID:sid];
    Photo *photo = status.photo;
    if (!status) {
        status = [NSEntityDescription insertNewObjectForEntityForName:STATUS_ENTITY inManagedObjectContext:self.context];
        //插入用户发布的图片url
        
        photo = [NSEntityDescription insertNewObjectForEntityForName:PHOTO_ENTITY inManagedObjectContext:self.context];
    }
    status.sid = statusProfile[@"id"];
    status.text = statusProfile[@"text"];
    status.source = statusProfile[@"source"];
    NSString *createdStr = statusProfile[@"created_at"];
    // NSLog(@"createdStr:%@",createdStr);
    
    status.created_at = [self dateFromString:createdStr];
    //
    NSString *favStr = statusProfile[@"favorited"];
    //布尔转成nsnumber
    status.favorited = @(favStr.boolValue);
    //更新用户图片url
    NSDictionary *photoDic = statusProfile[@"photo"];
    photo.imageurl = photoDic[@"imageurl"];
    photo.largeurl = photoDic[@"largeurl"];
    photo.thumburl = photoDic[@"thumburl"];
    status.photo = photo;
    
    
    NSDictionary *userDic = statusProfile[@"user"];
    //insert user
    User *user = [self insertOrUpdateWithUserProfile:userDic token:nil tokenSecret:nil];
    
    //set up relationship
    status.user = user;
    
    return status;
    
}
-(Status *)checkImportedWithStatusID:(NSString *)sid {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:STATUS_ENTITY];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sid like %@",sid];
    fr.predicate = predicate;
    NSError *error;
    NSArray *users = [self.context executeFetchRequest:fr error:&error];
    if (users.count > 0) {
        return users[0];
    }
    
    return nil;
}
- (NSFetchRequest *)photoFetchRequest {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"photo.imageurl != nil"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:NO];
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:STATUS_ENTITY];
    fr.predicate = pre;
    fr.sortDescriptors = @[sortDescriptor];
    return  fr;
    
}
//- (NSArray *)fetchPhotoStatusesWithStatusID:(NSString *)statusID {
//    return [self fetchObjectsWithPredicate:pre sortDescriptors:@[sortDescriptor] entityName:STATUS_ENTITY];
//}

- (BOOL)isObjectExistWithEntityName:(NSString *)entityName keyPath:(NSString *)keyPath uniqueID:(NSString *)uniqueID {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:entityName];
    if (uniqueID) {
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"%K = %@",keyPath,uniqueID];
        fr.predicate = pre;
    }
    //限制查询的数量
    fr.fetchLimit = 1;
    NSError *error;
    NSArray *objs = [self.context executeFetchRequest:fr error:&error];
    if (objs.count == 1) {
        return YES;
    }
    return NO;
}


- (BOOL)isStatusExist {
   return [self isObjectExistWithEntityName:STATUS_ENTITY keyPath:nil uniqueID:nil];
}

@end
