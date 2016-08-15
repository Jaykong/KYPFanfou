//
//  Message+CoreDataProperties.m
//  KYPFanfou
//
//  Created by JayKong on 8/11/16.
//  Copyright © 2016 trainer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Message+CoreDataProperties.h"

@implementation Message (CoreDataProperties)

@dynamic created_at;
@dynamic mid;
@dynamic recipient_id;
@dynamic recipient_screen_name;
@dynamic sender_id;
@dynamic sender_screen_name;
@dynamic text;
@dynamic recipient;
@dynamic sender;

@end
