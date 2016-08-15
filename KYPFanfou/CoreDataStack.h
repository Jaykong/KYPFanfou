//
//  CoreDataStack.h
//  KYPFanfou
//
//  Created by trainer on 7/26/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (nonatomic,strong)NSManagedObjectContext *context;
@property (nonatomic,strong) NSPersistentStoreCoordinator *coordinator;
+(instancetype)sharedCoreDataStack;
-(void)saveContext;
@end
