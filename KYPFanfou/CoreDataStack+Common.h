//
//  CoreDataStack+Common.h
//  KYPFanfou
//
//  Created by trainer on 8/5/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack (Common)
- (NSManagedObject *)findUniqueEntityWithUniqueKey:(NSString *)key value:(id)value entityName:(NSString *)entityName;
- (NSArray *)fetchObjectsWithUniqueKey:(NSString *)uniqueKey value:(id)value entityName:(NSString *)entityName sortKey:(NSString *)sortKey;
- (NSDate *)dateFromString:(NSString *)dateStr;
- (NSArray *)fetchObjectsWithPredicate:(NSPredicate *)pre sortDescriptors:(NSArray *)sortDescriptors entityName:(NSString *)entityName;
@end
