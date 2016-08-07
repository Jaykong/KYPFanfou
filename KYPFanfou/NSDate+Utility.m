//
//  NSDate+Utility.m
//  KYPFanfou
//
//  Created by JayKong on 8/7/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "NSDate+Utility.h"

@implementation NSDate (Utility)
- (NSString *)defaultDateString {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *str = [formater stringFromDate:self];
    return str;
}
@end
