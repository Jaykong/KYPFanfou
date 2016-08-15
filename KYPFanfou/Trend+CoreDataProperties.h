//
//  Trend+CoreDataProperties.h
//  KYPFanfou
//
//  Created by JayKong on 8/11/16.
//  Copyright © 2016 trainer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Trend.h"

NS_ASSUME_NONNULL_BEGIN

@interface Trend (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *query;
@property (nullable, nonatomic, retain) NSString *url;

@end

NS_ASSUME_NONNULL_END
