//
//  PhotoBrowseViewController.h
//  KYPFanfou
//
//  Created by JayKong on 8/9/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ARSegmentPager/ARSegmentPageController.h>
#import <CoreData/CoreData.h>
@interface PhotoBrowseViewController : UICollectionViewController<ARSegmentControllerDelegate,NSFetchedResultsControllerDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) NSFetchedResultsController *frc;
@end
