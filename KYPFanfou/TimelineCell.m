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
@interface TimelineCell() <DTAttributedTextContentViewDelegate>
@end

@implementation TimelineCell

- (void)configureWithStatus:(Status *)status; {
    self.nameLabel.text = status.user.name;
    //self.idLabel.text = status.user.uid;
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
    
    
    UINib *nib = [UINib nibWithNibName:@"CellToolbar" bundle:nil];
    NSArray *views = [nib instantiateWithOwner:nil options:nil];
    if (views.count > 0) {
        CellToolbar *cellToolbar = views[0];
        //  NSLog(@"%@",cellToolbar);
        //  _cellToolbar = cellToolbar;
        [_cellToolbar addSubview:cellToolbar];
        cellToolbar.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *topConstraint = [cellToolbar.topAnchor constraintEqualToAnchor:_cellToolbar.topAnchor];
        NSLayoutConstraint *bottomConstraint = [cellToolbar.bottomAnchor constraintEqualToAnchor:_cellToolbar.bottomAnchor];
        
        NSLayoutConstraint *leftConstraint = [cellToolbar.leftAnchor constraintEqualToAnchor:_cellToolbar.leftAnchor];
        
        NSLayoutConstraint *rightConstraint = [cellToolbar.rightAnchor constraintEqualToAnchor:_cellToolbar.rightAnchor];
        topConstraint.active = YES;
        bottomConstraint.active = YES;
        leftConstraint.active = YES;
        rightConstraint.active = YES;
        
    }
    
    
}
- (IBAction)showLargePhotoImage:(UIButton *)sender {
    NSLog(@"%s",__FUNCTION__);
    _didSelectPhotoBlock(self);
    
}

@end
