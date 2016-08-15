//
//  CoreDataStack+Keyword.m
//  KYPFanfou
//
//  Created by JayKong on 8/11/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataStack+Keyword.h"
#import "CoreDataStack+Status.h"
#import "CoreDataStack+Common.h"
#import "EntityNameConstant.h"
#import "CoreDataStack+Status.h"
#import "Keyword.h"
#import "Status.h"
@implementation CoreDataStack (Keyword)
- (void)addKeyword:(NSString *)query profile:(NSArray *)profile {
    Keyword *keyword = (Keyword *)[self findUniqueEntityWithUniqueKey:@"name" value:query entityName:KEYWORD_ENTITY];
    if (!keyword) {
        keyword = [NSEntityDescription insertNewObjectForEntityForName:KEYWORD_ENTITY inManagedObjectContext:self.context];
    }
    
    //关联，让你keyword 的statues可以引用到
   
    keyword.name = query;
    [profile enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Status *status = [self insertOrUpdateStatusWithStatusProfile:obj];
        [keyword addStatusesObject:status];
        status.keyword = keyword;
        //NSLog(@"status:%@",status);
        
    }];
    
    //[self saveContext];
}
//- (NSFetchRequest *)fetchedRequestWithEntityName:(NSString *)entityName  predicateKeyPath:(NSString *)predicateKeyPath predicateValue:(NSString *)predicateValue predicateCondition:(NSString *)predicateCondition sortKey:(NSString *)sortKey {
//    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:entityName];
//    if (predicateValue) {
//        fr.predicate = [NSPredicate predicateWithFormat:@"%K != nil",predicateKeyPath,predicateCondition,predicateValue];
//    }
//    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:NO];
//    fr.sortDescriptors = @[sd];
//    return fr;
//    
//}

- (NSFetchRequest *)fetchedRequestWithEntityName:(NSString *)entityName {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:entityName];
        fr.predicate = [NSPredicate predicateWithFormat:@"keyword != nil"];
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:NO];
    fr.sortDescriptors = @[sd];
    return fr;

}

//查询keyword的NSFetchRequest
//- (NSFetchRequest *)keywordFetchedRequest:(NSString *)query {
//    return [self fetchedRequestWithEntityName:KEYWORD_ENTITY predicateKeyPath:@"name" predicateValue:query predicateCondition:@"=" sortKey:@"name"];
//}
//在Status表里查找包含某个搜索关键字的NSFetchRequest
- (NSFetchRequest *)statusFetchedRequest {
    return [self fetchedRequestWithEntityName:STATUS_ENTITY];
}
@end
