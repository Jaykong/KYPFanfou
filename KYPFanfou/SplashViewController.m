//
//  SplashViewController.m
//  KYPFanfou
//
//  Created by trainer on 7/25/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "SplashViewController.h"
#import "CoreDataStack+User.h"
@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    dispatch_async(dispatch_get_main_queue(), ^{
        //根据数据库是否有用户作判断
        User *user = [CoreDataStack sharedCoreDataStack].currentUser;
        NSLog(@"%@",user);
        if (user) {
            [self performSegueWithIdentifier:@"MainSegue" sender:nil];
        } else {
            [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
        }
        
    });
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
