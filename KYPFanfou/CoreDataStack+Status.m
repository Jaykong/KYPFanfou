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
static NSString *const STATUS_ENTITY = @"Status";

@implementation CoreDataStack (Status)
- (void)insertOrUpdateStatusWithObjects:(NSArray *)objects {
    
    [objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // insure the date inserted
        [self.context performBlockAndWait:^{
           Status *status = [self insertOrUpdateStatusWithStatusProfile:obj];
            //insert user
            User *user = [self insertOrUpdateWithUserProfile:obj[@"user"] token:nil tokenSecret:nil];

            //set up relationship
            status.user = user;


        }];
    }];
}

- (Status *)insertOrUpdateStatusWithStatusProfile:(NSDictionary *)statusProfile{
    NSString *sid = statusProfile[@"id"];
    Status *status = [self checkImportedWithStatusID:sid];
    if (!status) {
        status = [NSEntityDescription insertNewObjectForEntityForName:STATUS_ENTITY inManagedObjectContext:self.context];
    }
    status.sid = statusProfile[@"id"];
    status.text = statusProfile[@"text"];
    status.source = statusProfile[@"source"];
    NSString *createdStr = statusProfile[@"created_at"];
    NSLog(@"createdStr:%@",createdStr);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"E MM dd HH:mm:ssZZZZZ yyyy";
    NSDate *createdDate = [dateFormatter dateFromString:createdStr];
    status.created_at = createdDate;
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

@end
