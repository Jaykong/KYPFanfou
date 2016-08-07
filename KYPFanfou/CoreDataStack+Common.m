//
//  CoreDataStack+Common.m
//  KYPFanfou
//
//  Created by trainer on 8/5/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataStack+Common.h"

@implementation CoreDataStack (Common)
//获取某条数据
//e.g User key=uid value=~4fjkleg
- (NSManagedObject *)findUniqueEntityWithUniqueKey:(NSString *)key value:(id)value entityName:(NSString *)entityName{
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@",key,value];
    fr.predicate = predicate;
    NSError *error;
    NSArray *users = [self.context executeFetchRequest:fr error:&error];
    if (users.count > 0) {
        return users[0];
    }
    return nil;
}

- (NSArray *)fetchObjectsWithUniqueKey:(NSString *)uniqueKey value:(id)value entityName:(NSString *)entityName sortKey:(NSString *)sortKey {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@",uniqueKey,value];
    fr.predicate = predicate;
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:YES];
    fr.sortDescriptors = @[descriptor];
    
    NSError *error;
    NSArray *arr = [self.context executeFetchRequest:fr error:&error];
    if (error) {
        return @[error.description];
    }
    return arr;
}

- (NSArray *)fetchObjectsWithPredicate:(NSPredicate *)pre sortDescriptors:(NSArray *)sortDescriptors entityName:(NSString *)entityName {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:entityName];
    fr.predicate = pre;
    fr.sortDescriptors = sortDescriptors;
    NSError *error;
    NSArray *arr = [self.context executeFetchRequest:fr error:&error];
    if (error) {
        return @[error.description];
    }
    return arr;
}
- (NSDate *)dateFromString:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"E MM dd HH:mm:ssZZZZZ yyyy";
    NSDate *createdDate = [dateFormatter dateFromString:dateStr];
    return createdDate;
}
@end
