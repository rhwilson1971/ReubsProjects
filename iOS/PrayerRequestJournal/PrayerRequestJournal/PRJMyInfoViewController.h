//
//  PRJMyInfoViewController.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 8/25/13.
//  Copyright (c) 2013 Reuben Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRJMyInfoViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField* FirstName;
@property (strong, nonatomic) IBOutlet UITextField* LastName;
@property (strong, nonatomic) IBOutlet UITextField* Email;


-(void)save:(id)sender;


@end
