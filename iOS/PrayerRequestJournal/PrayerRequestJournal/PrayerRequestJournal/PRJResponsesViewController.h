//
//  PRJResponsesViewController.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 9/6/13.
//  Copyright (c) 2013 Reuben Wilson. All rights reserved.
//

#define kRequestSection 0
#define kResponseSection 1

#import <UIKit/UIKit.h>
#import "PrayerRequest.h"
#import "PrayerResponse.h"

@interface PRJResponsesViewController : UITableViewController


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) PrayerRequest *currentPrayerRequest;

@end
