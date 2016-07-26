//
//  CoreDataStack+User.h
//  KYPFanfou
//
//  Created by trainer on 7/26/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack (User)
-(void)insertOrUpdateWithUserProfile:(NSDictionary *)userProfile token:(NSString *)token tokenSecret:(NSString *)tokenSecret;
@end
