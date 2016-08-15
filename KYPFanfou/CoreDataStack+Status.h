//
//  CoreDataStack+Status.h
//  KYPFanfou
//
//  Created by JayKong on 7/29/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataStack.h"
@class Status;
@interface CoreDataStack (Status)
- (void)insertOrUpdateStatusWithObjects:(NSArray *)objects;
- (Status *)insertOrUpdateStatusWithStatusProfile:(NSDictionary *)statusProfile;
- (NSFetchRequest *)photoFetchRequest;
- (BOOL)isStatusExist;
@end
