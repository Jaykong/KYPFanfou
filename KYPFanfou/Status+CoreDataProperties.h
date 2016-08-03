//
//  Status+CoreDataProperties.h
//  KYPFanfou
//
//  Created by JayKong on 7/31/16.
//  Copyright © 2016 trainer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Status.h"
#import "Photo.h"
NS_ASSUME_NONNULL_BEGIN

@interface Status (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *created_at;
@property (nullable, nonatomic, retain) NSString *sid;
@property (nullable, nonatomic, retain) NSString *source;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) User *user;
@property (nullable, nonatomic, retain) Photo *photo;

@end

NS_ASSUME_NONNULL_END