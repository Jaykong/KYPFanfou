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
#import <JTSImageViewController/JTSImageViewController.h>
#import <SDWebImage/SDImageCache.h>
#import "Photo.h"
#import "CellToolbar.h"
@interface TimelineTableViewController ()<JTSImageViewControllerInteractionsDelegate,CellToolbarDelegate>

@end

@implementation TimelineTableViewController
- (void)configureFetch {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:@"Status"];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:NO];
    NSArray *descriptors = @[descriptor];
    fr.sortDescriptors = descriptors;
    
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest: fr managedObjectContext:[CoreDataStack sharedCoreDataStack].context sectionNameKeyPath:nil cacheName:nil];
    self.frc.delegate = self;
}
//增加下拉刷新
- (void)creatRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新..."];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    
    
}
- (void)refreshData {
    NSLog(@"refresh");
    [self requestData];
    [self.refreshControl endRefreshing];
}
- (void)requestData {
    [[Service sharedInstance] requestStatusWithSucess:^(NSArray *result) {
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateStatusWithObjects:result];
        [self configureFetch];
        [self performFetch];
    } failure:^(NSError *error) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //增加下拉刷新
    [self creatRefreshControl];
    
    UINib *nib = [UINib nibWithNibName:@"TimelineCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TimelineCell"];
    [self requestData];
    self.tableView.estimatedRowHeight = 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showPhotoFromSourceCell:(TimelineCell *)timeLineCell photo:(Photo *)photo
{
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:photo.largeurl];
    
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    if (image) {
        imageInfo.image = image;
    } else {
        imageInfo.imageURL = [NSURL URLWithString:photo.largeurl];
    }
    
    //    if (timeLineCell) {
    //        imageInfo.referenceRect = timeLineCell.photoImage.frame;
    //        imageInfo.referenceView = timeLineCell.photoImage.superview;
    //    }
    //
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc] initWithImageInfo:imageInfo mode:JTSImageViewControllerMode_Image backgroundStyle:(JTSImageViewControllerBackgroundOption_Scaled | JTSImageViewControllerBackgroundOption_Blurred)];
    imageViewer.interactionsDelegate = self;
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimelineCell"];
    Status *status =  [self.frc objectAtIndexPath:indexPath];
    //NSLog(@"status:%@",status);
    [cell configureWithStatus:status];
    cell.didSelectPhotoBlock = ^
    (TimelineCell *cell) {
        [self showPhotoFromSourceCell:cell photo:status.photo];
        
    };
    //配置收藏按钮
    [cell.cellToolbar setupStarButtonWithBool:status.favorited.boolValue];
    cell.cellToolbar.delegate = self;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma  mark - Cell Toolbar Delegate
- (void)starWithCellToolbar:(CellToolbar *)toolbar sender:(id)sender forEvent:(UIEvent *)event {
    
    //取到收藏所在的indexPath，也就是所在的cell
    //取到所有的touches
    NSSet *touches = [event allTouches];//这个集合会记录一系列的点击事件
    //取到某一个touch
    UITouch *touch = [touches anyObject];
    //取到这个touch所在的位置location
    CGPoint point = [touch locationInView:self.tableView];
    //最后获取到这个位置所在的index path
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    //用frc取到这个cell下的status对象
    Status *status =  [self.frc objectAtIndexPath:indexPath];
    
    //请求收藏接口
    [[Service sharedInstance] starWithStatusID:status.sid sucess:^(NSArray *result) {
        NSLog(@"%@",result);
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateStatusWithStatusProfile:result];
        [toolbar setupStarButtonWithBool:status.favorited.boolValue];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

#pragma mark - <ARSegmentControllerDelegate>
- (NSString *)segmentTitle {
    return @"时间线";
}
@end
