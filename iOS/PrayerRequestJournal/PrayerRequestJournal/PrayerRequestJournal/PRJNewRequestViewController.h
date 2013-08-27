//
//  PRJSecondViewController.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 10/24/12.
//  Copyright (c) 2012 Reuben Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRJNewRequestViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>{

}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField *requestTitle;
@property (strong, nonatomic) IBOutlet UITextView *requestDetail;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIView *activeField;

-(void)cancel:(id)sender;
-(void)save:(id)sender;

//-(BOOL) findAndResignFirstResponder;
-(void) registerForKeyboardNotifications;
-(void) keyboardWasShown:(NSNotification*) aNotification;
-(void) keyboardWillBeHidden:(NSNotification *) aNotification;

@end
