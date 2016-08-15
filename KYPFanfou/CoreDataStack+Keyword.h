//
//  CoreDataStack+Keyword.h
//  KYPFanfou
//
//  Created by JayKong on 8/11/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack (Keyword)
- (void)addKeyword:(NSString *)query profile:(NSArray *)profile;
//查询keyword的NSFetchRequest
- (NSFetchRequest *)keywordFetchedRequest:(NSString *)query;
//查询status的NSFetchRequest
- (NSFetchRequest *)statusFetchedRequest;
//- (NSFetchRequest *)statusFetchedRequest:(NSString *)name;
@end
