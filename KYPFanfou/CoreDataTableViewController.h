//
//  CoreDataTableViewController.h
//  KYPFanfou
//
//  Created by trainer on 7/27/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface CoreDataTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic,strong)NSFetchedResultsController *frc;

-(void)performFetch;

@end
