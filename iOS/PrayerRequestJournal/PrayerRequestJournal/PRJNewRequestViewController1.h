//
//  PRJNewRequestViewController.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 9/2/13.
//  Copyright (c) 2013 Reuben Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRJNewRequestViewController1 : UITableViewController
{
    
}

@property (nonatomic, retain) IBOutlet UITextField * requestTitleField;
@property (nonatomic, retain) IBOutlet UITextView * requestDetailView;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
