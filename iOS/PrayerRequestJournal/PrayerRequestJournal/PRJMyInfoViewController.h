//
//  PRJMyInfoViewController.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 8/25/13.
//  Copyright (c) 2013 Reuben Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFirstNameTag 	1201
#define kLastNameTag 	1202
#define kEmailNameTag 	1203


@interface PRJMyInfoViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField* FirstName;
@property (strong, nonatomic) IBOutlet UITextField* LastName;
@property (strong, nonatomic) IBOutlet UITextField* Email;

-(void)save:(id)sender;

@end
