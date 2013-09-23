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
#import "PrayerRequest.h"

@interface PRJNewResponseViewController : UITableViewController<UITextViewDelegate>

@property (weak, nonatomic) PrayerResponse *prayerResponse;
@property (weak, nonatomic) PrayerRequest *prayerRequest;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
