//
//  UserTableViewController.m
//  KYPFanfou
//
//  Created by JayKong on 8/8/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "UserViewController.h"
#import "TimelineTableViewController.h"
#import "PhotoBrowseViewController.h"
#import "CoreDataStack+User.h"
#import "UserHeaderView.h"
#import "ModifyProfileTableViewController.h"
#import "UserTimelineTableViewController.h"
@interface UserViewController ()

@end

@implementation UserViewController

//override getter方法
//如果为nil，就是当前用户
- (NSString *)userID {
    if (_userID) {
        return _userID;
    }
    return [CoreDataStack sharedCoreDataStack].currentUser.uid;
    
}
-(UIView<ARSegmentPageControllerHeaderProtocol> *)customHeaderView {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"UserHeaderView" owner:nil options:nil];
    UserHeaderView *userHeaderView = [views lastObject];
    User *user = [[CoreDataStack sharedCoreDataStack] findUserWithId:self.userID];
    [userHeaderView configureViewWithUser:user];
    [userHeaderView updateProfileWithBlock:^(UserHeaderView *headerView, UIButton *sender) {
        //展示一个视图控制器
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ModifyProfile" bundle:nil];
        UINavigationController *modifyProfileTableViewController = [sb instantiateInitialViewController];
        [self presentViewController:modifyProfileTableViewController animated:YES completion:nil];
        
    }];
    NSLog(@"%s",__func__);
    return userHeaderView;
}
- (void)viewDidLoad {
/**
 1.取到timelineTableViewController
 2.把timelineTableViewController设为当前视图控制器的viewcontrollers属性
 3.让TimelineTableViewController实现ARsegmentcontroller delegate 协议
 */

    //取到已经生成的TimelineTableViewController对象
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Timeline" bundle:nil];
    TimelineTableViewController *timelineTableViewController = [storyboard instantiateViewControllerWithIdentifier:@"TimelineTableViewController"];
    //取到已经生成的PhotoBrowseViewController对象
    UIStoryboard *photoBrowse = [UIStoryboard storyboardWithName:@"PhotoBrowse" bundle:nil];
    PhotoBrowseViewController *photoBrowseViewController = [photoBrowse instantiateViewControllerWithIdentifier:@"PhotoBrowseViewController"];
    photoBrowseViewController.userID = self.userID;


    UIStoryboard *userTimelineSB = [UIStoryboard storyboardWithName:@"UserTimeline" bundle:nil];
    UserTimelineTableViewController *userTimelineTableViewController = [userTimelineSB instantiateInitialViewController];

    //把要放在segment control的视图控制器加进来
    [self setViewControllers:@[timelineTableViewController,photoBrowseViewController,userTimelineTableViewController]];
    self.segmentMiniTopInset = 0;//
    self.headerHeight = 200;
    [super viewDidLoad];
}
- (void)dealloc {
    NSLog(@"%@",self);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
