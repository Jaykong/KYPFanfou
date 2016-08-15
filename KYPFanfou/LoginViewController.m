//
//  LoginViewController.m
//  KYPFanfou
//
//  Created by trainer on 7/25/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "LoginViewController.h"
#import "Service.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)login:(UIBarButtonItem *)sender {
    
    // login sucess
    [[Service sharedInstance] authoriseWithUserName:@"kongyunpeng2012@sina.com" password:@"1234" success:^(NSString *token, NSString *tokenSecret) {
        [[Service sharedInstance] requestVerifyCredential:nil accessToken:token tokenSecret:tokenSecret requestMethod:@"GET" sucess:^(NSDictionary *result) {
            [self performSegueWithIdentifier:@"ShowAccountsSegue" sender:nil];
        }];
    }];

    // login fail
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
