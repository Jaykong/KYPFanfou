//
//  ComposeViewController.h
//  KYPFanfou
//
//  Created by trainer on 8/3/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,strong) IBOutlet UIImageView *pickerImageView;
@property (nonatomic,strong) NSString *placeHolder;
@property (nonatomic,strong) NSAttributedString *attriPlaceHolder;
@end
