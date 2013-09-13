//
//  PRJNewResponseViewController.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 9/10/13.
//  Copyright (c) 2013 Reuben Wilson. All rights reserved.
//

#define kDispostionTag 1301
#define kResponseTag 1302

#import <UIKit/UIKit.h>
#import "PrayerResponse.h"

@interface PRJNewResponseViewController : UITableViewController<UITextViewDelegate>


@property (strong, nonatomic) PrayerResponse *prayerResponse;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet UISegmentedControl * dispositionsSegmentedControl;
@property (nonatomic, retain) IBOutlet UITextView * responseDetail;


@end
