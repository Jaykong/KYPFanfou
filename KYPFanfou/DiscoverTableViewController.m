//
//  DiscoverTableViewController.m
//  KYPFanfou
//
//  Created by JayKong on 8/11/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "Trend.h"
#import "EntityNameConstant.h"
#import "CoreDataStack.h"
#import "Service+Discover.h"
#import "CoreDataStack+Trend.h"
#import "SearchResultTableViewController.h"
@interface DiscoverTableViewController ()

@end

@implementation DiscoverTableViewController


- (void)configureFetch {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:TREND_ENTITY];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    fr.sortDescriptors = @[sortDescriptor];
    
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fr managedObjectContext:[CoreDataStack sharedCoreDataStack].context sectionNameKeyPath:nil cacheName:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[Service sharedInstance] requestTrendsSucess:^(id result) {
        [[CoreDataStack sharedCoreDataStack] addTrendsWithDictionary:result];
        [self configureFetch];
        [self performFetch];
        NSLog(@"%@",result);
    } failure:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
   return [super tableView:tableView numberOfRowsInSection:0];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverCell"];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"随便看看";
        cell.detailTextLabel.text = nil;
        return cell;
    }
    indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    Trend *trend = [self.frc objectAtIndexPath:indexPath];
    cell.textLabel.text = trend.name;
    cell.detailTextLabel.text = trend.query;

    return cell;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    return @"热门话题";
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SearchResultTableViewController *searchResultTableViewController = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Trend *trend = [self.frc objectAtIndexPath:indexPath];
    //传值
    searchResultTableViewController.query = trend.name;
    
}

@end
