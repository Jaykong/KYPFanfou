//
//  TimelineTableViewController.h
//  KYPFanfou
//
//  Created by JayKong on 7/29/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import <ARSegmentPager/ARSegmentPageController.h>
#import "ComposeViewController.h"
#import "UserViewController.h"
#import "CoreDataStack.h"
#import "TimelineCell.h"
#import "Status.h"
#import "Service.h"
#import "CoreDataStack+Status.h"
#import <JTSImageViewController/JTSImageViewController.h>
#import <SDWebImage/SDImageCache.h>
#import "Photo.h"
#import "CellToolbar.h"
#import <DTCoreText/DTLinkButton.h>
@interface TimelineTableViewController : CoreDataTableViewController <ARSegmentControllerDelegate>
- (void)requestData;
- (void)configureFetch;
- (void)requestDataIfNeeded;
@end
