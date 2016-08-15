//
//  UserTimelineTableViewController.m
//  KYPFanfou
//
//  Created by trainer on 8/12/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "UserTimelineTableViewController.h"
#import "CoreDataStack+User.h"
#import "Service+Status.h"
@interface UserTimelineTableViewController ()
{
    NSString *userID;
}

@end

@implementation UserTimelineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)configureFetch {
    
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:@"Status"];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:NO];
    NSArray *descriptors = @[descriptor];
    fr.sortDescriptors = descriptors;
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"user.uid = %@",userID];
    fr.predicate = pre;
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest: fr managedObjectContext:[CoreDataStack sharedCoreDataStack].context sectionNameKeyPath:nil cacheName:nil];
    self.frc.delegate = self;
}
- (void)requestData {
    User *user = [CoreDataStack sharedCoreDataStack].currentUser;
    userID = user.uid;
    [[Service sharedInstance] user_timelineWithUserID:userID sucess:^(id result) {
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateStatusWithObjects:result];
        [self configureFetch];
        [self performFetch];
    } failure:^(NSError *error) {

    }];
    

}
- (void)requestDataIfNeeded {
    [self requestData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (NSString *)segmentTitle {
    return @"我发的饭";
}
@end
