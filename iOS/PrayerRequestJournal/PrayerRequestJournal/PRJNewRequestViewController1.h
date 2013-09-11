//
//  PRJNewRequestViewController.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 9/2/13.
//  Copyright (c) 2013 Reuben Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrayerRequestor.h"
#import "PrayerRequest.h"

#define kRequestTitleTag 		1011
#define kRequestDetailsTag 		1012
#define kInputSections 			2
#define kInputRows 				1
#define kRequestTitleSection 	0
#define kRequestDetailSection 	1

@interface PRJNewRequestViewController1 : UITableViewController<UITextFieldDelegate,UITextViewDelegate>
{
    
}

@property (nonatomic, retain) IBOutlet UITextField * requestTitleField;
@property (nonatomic, retain) IBOutlet UITextView * requestDetailView;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) PrayerRequestor *prayerRequestor;
@property (strong, nonatomic) PrayerRequest *prayerRequest;

-(void)cancel:(id)sender;
-(void)save:(id)sender;

//-(BOOL) findAndResignFirstResponder;
-(void) registerForKeyboardNotifications;
-(void) keyboardWasShown:(NSNotification*) aNotification;
-(void) keyboardWillBeHidden:(NSNotification *) aNotification;

//-(void) goToTitleField;

@end
