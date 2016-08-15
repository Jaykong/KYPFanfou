//
//  ComposeViewController.m
//  KYPFanfou
//
//  Created by trainer on 8/3/16.
//  Copyright © 2016 trainer. All rights reserved.
//
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\n %s:%d   %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[[NSString alloc] initWithData:[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] dataUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] UTF8String]);
#else
#define NSLog(...)
#endif
#import "ComposeViewController.h"
#import "Service.h"
@interface ComposeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ComposeViewController
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)takePhoto:(id)sender {
    //创建picker controller
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //set delegate
    picker.delegate = self;
    //present
    [self presentViewController:picker animated:NO completion:nil];
    
    
}
#pragma mark - Picker Delegate

// success load
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //get the original image
    _pickerImageView.image = info[UIImagePickerControllerOriginalImage];
    //dissmiss picker view controller back to send page
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
- (IBAction)postContent:(id)sender {
    NSData *data = UIImageJPEGRepresentation(_pickerImageView.image, 0.5);
    [[Service sharedInstance] postData:_textView.text imageData:data replyToStatusID:nil repostStatusID:nil sucess:^(NSArray *result) {
        NSLog(@"%@",result);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   // _textView.text = _placeHolder;
    _textView.attributedText = _attriPlaceHolder;
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
