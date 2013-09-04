//
//  PRJFirstViewController.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 10/24/12.
//  Copyright (c) 2012 Reuben Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface PRJAllRequestsViewController : UITableViewController {
    NSMutableArray *prayerRequests;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end
