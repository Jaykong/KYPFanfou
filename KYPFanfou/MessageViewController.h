//
//  MessageViewController.h
//  KYPFanfou
//
//  Created by JayKong on 8/7/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JSQMessagesViewController/JSQMessagesViewController.h>
@interface MessageViewController : JSQMessagesViewController
//对应的是展示这个神力控制器的ConversationController传过来的other id
@property (nonatomic,strong) NSString *userID;
@end
