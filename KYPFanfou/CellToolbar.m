//
//  CellToolbar.m
//  KYPFanfou
//
//  Created by JayKong on 7/31/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CellToolbar.h"

@implementation CellToolbar
- (IBAction)reply:(id)sender forEvent:(UIEvent *)event {
}

- (IBAction)star:(id)sender forEvent:(UIEvent *)event {
    [_delegate starWithCellToolbar:self sender:sender forEvent:event];
}

- (IBAction)repost:(id)sender forEvent:(UIEvent *)event {
    
}

- (void)setupStarButtonWithBool:(Boolean)favorited {
    if (favorited) {
        [_starBtn setTitle:@"已收藏" forState:UIControlStateNormal]  ;
    } else {
        [_starBtn setTitle:@"收藏" forState:UIControlStateNormal]  ;
    }
}

@end
