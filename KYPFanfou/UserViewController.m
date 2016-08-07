//
//  UserTableViewController.m
//  KYPFanfou
//
//  Created by JayKong on 8/8/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "UserViewController.h"
#import "TimelineTableViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

-(UIView<ARSegmentPageControllerHeaderProtocol> *)customHeaderView {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"UserHeaderView" owner:nil options:nil];
    return [views lastObject];
}
- (void)viewDidLoad {
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Timeline" bundle:nil];
    TimelineTableViewController *timelineTableViewController = [storyboard instantiateViewControllerWithIdentifier:@"TimelineTableViewController"];
    [self setViewControllers:@[timelineTableViewController]];
    self.segmentMiniTopInset = 64;
    [super viewDidLoad];
    
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

@end
