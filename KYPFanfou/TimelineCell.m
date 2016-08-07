//
//  TimelineCell.m
//  KYPFanfou
//
//  Created by trainer on 7/28/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "TimelineCell.h"
#import "Status.h"
#import "User.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CellToolbar.h"
#import "DTAttributedLabel.h"
#import "NSMutableAttributedString+HTML.h"
#import <DTCoreText.h>
@interface TimelineCell() <DTAttributedTextContentViewDelegate> {

}
@end

@implementation TimelineCell
@synthesize cellToolbar;
- (void)configureWithStatus:(Status *)status; {
    self.nameLabel.text = status.user.name;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    self.dateCreatedLbl.text = [formatter stringFromDate:status.created_at ];
    
    NSDictionary *options = @{
                              DTDefaultFontName:@"HelveticaNeue-Light",
                              DTDefaultFontSize:@16,
                              DTDefaultLinkColor:[UIColor blueColor]
                              };
    NSAttributedString *attribStr = [[NSAttributedString alloc] initWithHTMLData:[status.text dataUsingEncoding:NSUnicodeStringEncoding] options:options documentAttributes:nil];
    // NSAttributedString *attribStr = [[NSAttributedString alloc] initWithString:status.text] ;
    self.contentsLbl.attributedString = attribStr;
    self.contentsLbl.numberOfLines = 0;
    
    _contentsLblHeightConstraint.constant = [self.contentsLbl intrinsicContentSize].height;
    NSURL *url = [NSURL URLWithString:status.user.iconURL];
    [self.iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"BackgroundAvatar"] options:SDWebImageProgressiveDownload];
    
    NSURL *photoURL = [NSURL URLWithString:status.photo.imageurl];
    if (photoURL) {
        _imageHeightConstraint.constant = 200;
        [self.photoImage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"BackgroundImage"] options:SDWebImageProgressiveDownload];
    } else {
        //[self.photoImage sd_setImageWithURL:photoURL placeholderImage:nil options:SDWebImageProgressiveDownload];
        _imageHeightConstraint.constant = 0;
        
    }
    
    //创建cell tool bar
    
    cellToolbar = [self creatCellToolbar];
    /**
     作代码布局要注间哪两点
     1.automask NO，这两个是冲突的
     2.视图的层次关系要加好，也是要加好subviews
     */

    //取消Autoresizing的自动约束
    cellToolbar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.toolbar addSubview:cellToolbar];
    //创建约束
    NSLayoutConstraint *top = [cellToolbar.topAnchor constraintEqualToAnchor:self.toolbar.topAnchor];
    NSLayoutConstraint *bottom = [cellToolbar.bottomAnchor constraintEqualToAnchor:self.toolbar.bottomAnchor];
    NSLayoutConstraint *left = [cellToolbar.leftAnchor constraintEqualToAnchor:self.toolbar.leftAnchor];
    NSLayoutConstraint *right = [cellToolbar.rightAnchor constraintEqualToAnchor:self.toolbar.rightAnchor];
    //激活约束
    top.active = YES;
    bottom.active = YES;
    left.active = YES;
    right.active = YES;

}
//创建cell tool bar
- (CellToolbar *)creatCellToolbar {
    //从bundle里面根据xib创建views
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CellToolbar" owner:nil options:nil];
    //当前nsarray 只有一个对象
    CellToolbar *cellTboolbar = views[0];
    return cellTboolbar;
}

- (IBAction)showLargePhotoImage:(UIButton *)sender {
    NSLog(@"%s",__FUNCTION__);
    _didSelectPhotoBlock(self);
    
}

@end
