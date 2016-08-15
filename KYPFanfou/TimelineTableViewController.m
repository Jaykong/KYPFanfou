//
//  TimelineTableViewController.m
//  KYPFanfou
//
//  Created by JayKong on 7/29/16.
//  Copyright © 2016 trainer. All rights reserved.
//
#import "TimelineTableViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "User.h"
@interface TimelineTableViewController ()<JTSImageViewControllerInteractionsDelegate,CellToolbarDelegate,TimelineCellDelegate>

@end

@implementation TimelineTableViewController

//over ride by subclass
- (void)configureFetch {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:@"Status"];
    //方法一：增加一个字段或者属性
    //statusType
    //Timeline
    //LookAround
    //Keyword
    //{s1(七夕),s2(七夕),s3(七夕)}
    //方法二：增加几张表
    //增加Keyword
    //keyword.name = @"七夕" ->{s1,s2,s3}
    
    /*
     表名Status
     字段名称 keyword text date sid
     字段值'valantine" "t1" "d1" "id1"
     字段值'valantine" "t2" "d2" "id2"
     字段值'valantine" "t3" "d3" "id3"
     */
    
    /*
     表名Keyword
     字段名称  name date sid
     字段值 "valantine" "d1" "id1"
     关系表  statuses{s1,s2,s3}
     */
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:NO];
    NSArray *descriptors = @[descriptor];
    fr.sortDescriptors = descriptors;
    // NSPredicate *pre = [NSPredicate predicateWithFormat:@"userID = %@",userID];
    //user.uid = @""
    // fr.predicate = pre;
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
//在请求数据之前检查数据库是不是已经有数据
- (void)requestDataIfNeeded {
    if (![[CoreDataStack sharedCoreDataStack ] isStatusExist]) {
        [self requestData];
    } else {
        [self configureFetch];
        [self performFetch];
    }
}
//over ride by subclass
- (void)requestData {
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    // hud.contentColor = [UIColor blackColor];
    [[Service sharedInstance] requestStatusWithSucess:^(NSArray *result) {
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateStatusWithObjects:result];
        [self configureFetch];
        [self performFetch];
        
        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
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
    // [self requestData];
    [self requestDataIfNeeded];
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
    [cell configureWithStatus:status];
    cell.didSelectPhotoBlock = ^
    (TimelineCell *cell) {
        [self showPhotoFromSourceCell:cell photo:status.photo];
        
    };
    //配置收藏按钮
    [cell.cellToolbar setupStarButtonWithBool:status.favorited.boolValue];
    cell.cellToolbar.delegate = self;
    cell.delegate = self;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma  mark - Cell Toolbar Delegate
- (Status *)statusAtIndexPathForEvent:(UIEvent *)event {
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
    return status;
}
//收藏
- (void)starWithCellToolbar:(CellToolbar *)toolbar sender:(id)sender forEvent:(UIEvent *)event {
    
    Status *status = [self statusAtIndexPathForEvent:event];
    
    //请求收藏接口
    [[Service sharedInstance] starWithStatusID:status.sid sucess:^(id result) {
        NSLog(@"%@",result);
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateStatusWithStatusProfile:result];
        [toolbar setupStarButtonWithBool:status.favorited.boolValue];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (ComposeViewController *)createComposeViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Compose" bundle:nil];
    ComposeViewController *composeViewController = [sb instantiateInitialViewController];
    return composeViewController;
}
//回复
- (void)replyWithCellToolbar:(CellToolbar *)toolbar sender:(id)sender forEvent:(UIEvent *)event {
    Status *status = [self statusAtIndexPathForEvent:event];
    ComposeViewController *composeViewController = [self createComposeViewController];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor blueColor]};
    NSAttributedString *attiStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"@%@",status.user.name] attributes:attributes];
    composeViewController.attriPlaceHolder = attiStr;
    [self showViewController:composeViewController sender:sender];
}

//转发
- (void)repostWithCellToolbar:(CellToolbar *)toolbar sender:(id)sender forEvent:(UIEvent *)event {
    Status *status = [self statusAtIndexPathForEvent:event];

    // composeViewController.placeHolder = [NSString stringWithFormat:@"@%@ %@",status.user.uid,status.text];
    ComposeViewController *composeViewController = [self createComposeViewController];
    NSDictionary *dic = @{NSForegroundColorAttributeName :[UIColor blueColor]};
    NSString *atUID = [NSString stringWithFormat:@"@%@ %@",status.user.uid,status.text];
    NSAttributedString *atUID2 = [[NSAttributedString alloc] initWithString:atUID attributes:dic];
    NSMutableAttributedString *mutaStr = [atUID2 mutableCopy];
    [mutaStr setAttributes:dic range:[atUID rangeOfString:status.user.uid]];
    composeViewController.attriPlaceHolder = atUID2;

    [self presentViewController:composeViewController animated:YES completion:nil];
    
    
}
#pragma mark - <ARSegmentControllerDelegate>
- (NSString *)segmentTitle {
    return @"时间线";
}

#pragma mark - <TimelineCellDelegate>
- (void)didTouchupLinkButton:(DTLinkButton *)button timelineCell:(TimelineCell *)timelineCell {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    UserViewController *userViewController = [sb instantiateViewControllerWithIdentifier:@"UserViewController"];
    NSURL *url = button.URL;
    userViewController.userID = [url lastPathComponent];
    [self showViewController:userViewController sender:button];
    
}
@end
