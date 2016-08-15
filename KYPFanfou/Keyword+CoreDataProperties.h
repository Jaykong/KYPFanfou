//
//  Keyword+CoreDataProperties.h
//  KYPFanfou
//
//  Created by JayKong on 8/11/16.
//  Copyright © 2016 trainer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Keyword.h"

NS_ASSUME_NONNULL_BEGIN

@interface Keyword (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Status *> *statuses;

@end

@interface Keyword (CoreDataGeneratedAccessors)

- (void)addStatusesObject:(Status *)value;
- (void)removeStatusesObject:(Status *)value;
- (void)addStatuses:(NSSet<Status *> *)values;
- (void)removeStatuses:(NSSet<Status *> *)values;

@end

NS_ASSUME_NONNULL_END
