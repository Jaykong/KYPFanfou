//
//  CoreDataStack+Trend.m
//  KYPFanfou
//
//  Created by JayKong on 8/11/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataStack+Trend.h"
#import "CoreDataStack+Common.h"
#import "EntityNameConstant.h"
#import "Trend.h"
@implementation CoreDataStack (Trend)
//插入一条trend
- (void)insertOrUpdateTrendWithDictionary:(NSDictionary *)dic {
    NSString *name = dic[@"name"];
    NSString *query = dic[@"query"];
    NSString *url = dic[@"url"];
    //唯一性判断
    Trend *trend = (Trend *)[self findUniqueEntityWithUniqueKey:@"name" value:name entityName:TREND_ENTITY];
    if (!trend) {
        trend = [NSEntityDescription insertNewObjectForEntityForName:TREND_ENTITY inManagedObjectContext:self.context];
    }
    trend.name = name;
    trend.query = query;
    trend.url = url;
    
}
//插入多个Trend的方法
- (void)addTrendsWithDictionary:(NSDictionary *)dic {
    NSArray *trends = dic[@"trends"];
    [trends enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.context performBlockAndWait:^{
            [self insertOrUpdateTrendWithDictionary:obj];
        }];
    }];
}
@end
