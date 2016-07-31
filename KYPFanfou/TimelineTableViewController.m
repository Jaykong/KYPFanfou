//
//  TimelineTableViewController.m
//  KYPFanfou
//
//  Created by JayKong on 7/29/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "TimelineTableViewController.h"
#import "CoreDataStack.h"
#import "TimelineCell.h"
#import "Status.h"
#import "Service.h"
#import "CoreDataStack+Status.h"
@interface TimelineTableViewController ()

@end

@implementation TimelineTableViewController
- (void)configureFetch {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:@"Status"];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:YES];
    NSArray *descriptors = @[descriptor];
    fr.sortDescriptors = descriptors;
    
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest: fr managedObjectContext:[CoreDataStack sharedCoreDataStack].context sectionNameKeyPath:nil cacheName:nil];
    self.frc.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UINib *nib = [UINib nibWithNibName:@"TimelineCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TimelineCell"];
    [[Service sharedInstance] requestStatusWithSucess:^(NSArray *result) {
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateStatusWithObjects:result];
        [self configureFetch];
        [self performFetch];
        
        
    } failure:^(NSError *error) {
        
    }];
    self.tableView.estimatedRowHeight = 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimelineCell"];
    Status *status =  [self.frc objectAtIndexPath:indexPath];
    NSLog(@"status:%@",status);
    [cell configureWithStatus:status];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
