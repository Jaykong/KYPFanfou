//
//  SearchResultTableViewController.m
//  KYPFanfou
//
//  Created by JayKong on 8/11/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "TestTableViewController.h"
#import "EntityNameConstant.h"
#import "CoreDataStack+Keyword.h"
#import "Service+Discover.h"
#import "Status.h"
#import "TimelineCell.h"
@interface SearchResultTableViewController ()
@property (nonatomic,strong) UISearchController *searchController ;
//@property (nonatomic,strong) NSManagedObjectContext *context;
@end

@implementation SearchResultTableViewController
//-(NSManagedObjectContext *)context {
//    if (_context) {
//        return _context;
//    }
//
//    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//    [_context setPersistentStoreCoordinator:[CoreDataStack sharedCoreDataStack].coordinator];
//    return _context;
//}
- (void)configureFetch {
    NSFetchRequest *fr = [[CoreDataStack sharedCoreDataStack] statusFetchedRequest];
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fr managedObjectContext:[CoreDataStack sharedCoreDataStack].context sectionNameKeyPath:nil cacheName:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"TimelineCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TimelineCell"];
    TestTableViewController *testTableViewController = [[TestTableViewController alloc] initWithNibName:nil bundle:nil];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:testTableViewController];
    self.tableView.tableHeaderView = _searchController.searchBar;
    _searchController.obscuresBackgroundDuringPresentation = YES;
    
    [[Service sharedInstance] searchStatusesWithQuery:_query sucess:^(id result) {
        [[CoreDataStack sharedCoreDataStack] addKeyword:_query profile:result];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimelineCell"];
    Status *status =  [self.frc objectAtIndexPath:indexPath];
    NSLog(@"%@",status);
    [cell configureWithStatus:status];
//    cell.didSelectPhotoBlock = ^
//    (TimelineCell *cell) {
//        [self showPhotoFromSourceCell:cell photo:status.photo];
//        
//    };
//    //配置收藏按钮
//    [cell.cellToolbar setupStarButtonWithBool:status.favorited.boolValue];
//    cell.cellToolbar.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
