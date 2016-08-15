//
//  PhotoBrowseViewController.m
//  KYPFanfou
//
//  Created by JayKong on 8/9/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "PhotoBrowseViewController.h"
#import "Service+Photo.h"
#import "CoreDataStack+Status.h"
#import "PhotoCollectionViewCell.h"
#import "Status.h"
@interface PhotoBrowseViewController ()

@end

@implementation PhotoBrowseViewController
//创建frc
- (void)configureFetch {
    NSFetchRequest *fr = [[CoreDataStack sharedCoreDataStack] photoFetchRequest];
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fr managedObjectContext:[CoreDataStack sharedCoreDataStack].context sectionNameKeyPath:nil cacheName:nil];
}
//perform frc是为了从数据库取数据
- (void)performFetch {
    if (self.frc) {
        NSError *error;
        if(![self.frc performFetch:&error]) {
            NSLog(@"%@",error.description);
        }
        [self.collectionView reloadData];
    }
}
- (void)requestData {
    
    [[Service sharedInstance] getPhotosUserTimelineWithUserID:_userID sucess:^(id result) {
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateStatusWithObjects:result];
        [self configureFetch];
        [self performFetch];
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Datasource With FRC
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[self.frc sections] objectAtIndex:section] numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionCell" forIndexPath:indexPath];

    return cell;
    
}
//预加载
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    Status *status = [self.frc objectAtIndexPath:indexPath];
    PhotoCollectionViewCell *photoCell = (PhotoCollectionViewCell *)cell;
    [photoCell configureCellWithStatus:status];
    
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.collectionView insertItemsAtIndexPaths:@[newIndexPath]];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            break;
        case NSFetchedResultsChangeDelete:
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            break;
        default:
            break;
    }
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - ARSegmentControllerDelegate
-(NSString *)segmentTitle {
    return @"图片";
}
- (UIScrollView *)streachScrollView {
    return self.collectionView;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(200, 200);
}
@end
