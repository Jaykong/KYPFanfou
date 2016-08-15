//
//  UserHeaderView.m
//  KYPFanfou
//
//  Created by JayKong on 8/8/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "UserHeaderView.h"
#import "CoreDataStack+User.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface UserHeaderView()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *idLbl;
@property (weak, nonatomic) IBOutlet UIButton *modifiedBtn;
@property (weak, nonatomic) IBOutlet UIButton *followingBtn;
@property (weak, nonatomic) IBOutlet UIButton *followersBtn;
@property (weak, nonatomic) IBOutlet UIButton *numberOfMsgBtn;//发饭条数
@property (nonatomic,strong) UpdateAccountProfile updateAccountProfile;
@end
@implementation UserHeaderView
- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(configureViewWithUser:)
                                                 name:@"SomethingChanged"
                                               object:nil];
    //[self configureView];
}
- (void)updateProfileWithBlock:(UpdateAccountProfile)updateAccountProfile {
    _updateAccountProfile = updateAccountProfile;
}
- (void)configureViewWithUser:(User *)user {
    NSLog(@"%s",__func__);
    //用户信息
    if (!user) {
        user = [CoreDataStack sharedCoreDataStack].currentUser; 
    }
    // User *user = [CoreDataStack sharedCoreDataStack].currentUser;
    //头像从网络上取
    NSURL *url = [NSURL URLWithString:user.iconURL];
    NSLog(@"%@",url);
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"%lu",data.length);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%s",__func__);
            @synchronized(_iconImageView)  {
                //                    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                //                    NSLog(@"%@",self);
                //                    [_iconImageView addSubview:imageView];
                
                
                _iconImageView.image = image;
                NSLog(@"_iconImageView:%@",_iconImageView);
                [self setNeedsDisplay];
                
            }
            
        });
        
    }];
    
    [task resume];
    //    
    //    [_iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"BackgroundAvatar"]  options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //        NSLog(@"%ld",(long)cacheType);
    //        cacheType = SDImageCacheTypeNone;
    //    }];
    //
    //label显示的内容
    _nameLbl.text = user.name;
    _idLbl.text = user.uid;
    
    //button的文字内容
    NSString *_followers = [NSString stringWithFormat:@"%@粉丝",user.followers_count];
    [_followersBtn setTitle:_followers forState:UIControlStateNormal];
    
    NSString *friends_count = [NSString stringWithFormat:@"%@好友",user.friends_count];
    [_followingBtn setTitle:friends_count forState:UIControlStateNormal];
    
    NSString *statuses_count = [NSString stringWithFormat:@"%@消息",user.statuses_count];
    [_numberOfMsgBtn setTitle:statuses_count forState:UIControlStateNormal];
    
    
    [_modifiedBtn setTitle:@"修改个人信息" forState:UIControlStateNormal];
    
    
}
- (IBAction)updateAccountProfile:(id)sender {
    _updateAccountProfile(self,sender);
}

- (void)dealloc {
    NSLog(@"dealloc%@",self);
}
@end
