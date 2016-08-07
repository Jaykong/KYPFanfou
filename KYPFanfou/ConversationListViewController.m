//
//  ConversationListViewController.m
//  KYPFanfou
//
//  Created by trainer on 8/5/16.
//  Copyright © 2016 trainer. All rights reserved.
//
#import "UserTableViewCell.h"
#import "ConversationListViewController.h"
#import "Service+Conversation.h"
#import "CoreDataStack+Conversation.h"
#import "EntityNameConstant.h"
#import "Conversation.h"
#import "MessageViewController.h"
@interface ConversationListViewController ()

@end

@implementation ConversationListViewController

- (void)configureFetch {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:CONVERSATION_ENTITY];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"message.created_at" ascending:NO];
    NSArray *descriptors = @[descriptor];
    fr.sortDescriptors = descriptors;
    
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest: fr managedObjectContext:[CoreDataStack sharedCoreDataStack].context sectionNameKeyPath:nil cacheName:nil];
    self.frc.delegate = self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //向服务请求用户列表（和你聊过天的用户）
    //conversation list API
    
    [[Service sharedInstance] conversationListSucess:^(NSArray *result) {
        [[CoreDataStack sharedCoreDataStack] addConversationsWithArrayProfile:result];
        //当数据请求成功并插入数据了
        [self configureFetch];
        [self performFetch];
    } failure:^(NSError *error) {
        
    }];
}

//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    Conversation *ct =  [self.frc objectAtIndexPath:indexPath];
    [cell configureWithConversation:ct];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    MessageViewController *messageViewController = segue.destinationViewController;
    messageViewController.hidesBottomBarWhenPushed = YES;
    Conversation *ct =  [self.frc objectAtIndexPath:indexPath];
    messageViewController.userID = ct.otherid;
}


@end
