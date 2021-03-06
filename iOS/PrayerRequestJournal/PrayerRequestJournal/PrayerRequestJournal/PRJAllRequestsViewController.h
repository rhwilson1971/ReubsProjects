//
//  PRJAllRequestsViewController.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 10/24/12.
//  Copyright (c) 2012 Reuben Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>
#import "PrayerRequestor.h"

@interface PRJAllRequestsViewController : UITableViewController 

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) PrayerRequestor *MyPrayerRequestor;

@end
