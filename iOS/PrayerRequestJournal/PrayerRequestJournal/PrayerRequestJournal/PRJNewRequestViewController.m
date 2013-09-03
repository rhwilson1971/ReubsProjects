//
//  PRJSecondViewController.m
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 10/24/12.
//  Copyright (c) 2012 Reuben Wilson. All rights reserved.
//

#import "PRJNewRequestViewController.h"
#import "PrayerRequest.h"

@interface PRJNewRequestViewController ()

@end

@implementation PRJNewRequestViewController
@synthesize managedObjectContext;
@synthesize requestTitle;
@synthesize requestDetail;
@synthesize scrollView;
@synthesize activeField; // create both getter & setter for activeField property


//@synthesize activeField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"New Request", @"New Request");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain
                                                                  target:self action:@selector(save:)];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain
                                                                    target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    // Observe keyboard hide and show notifications to resize the text view appropriately.
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    requestTitle.text = @"Prayer Request Title";
    requestDetail.text = @"Prayer Request";
    
    requestDetail.delegate = self;
    requestTitle.delegate = self;
    
    scrollView.scrollEnabled = YES;
    
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancel:(id)sender
{
    NSLog(@"Cancel pressed");
    
    [activeField resignFirstResponder];
}

    
- (void)save:(id)sender
{
    
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSManagedObject *prayerRequestObject;
    
    NSError *error = nil;
    
    prayerRequestObject = [NSEntityDescription insertNewObjectForEntityForName:@"PrayerRequest" inManagedObjectContext:moc];
    
    
    NSDate *dateRequested = [NSDate date];
    
    [prayerRequestObject setValue:requestTitle.text forKey:@"title"];
    [prayerRequestObject setValue:requestDetail.text forKey:@"detail"];
    [prayerRequestObject setValue:dateRequested forKey:@"dateRequested"];
    
    [moc save:&error];
    if(nil != error)
    {
        NSLog(@"Error occurred saving prayer request");
    }
    
	NSLog(@"Save button pressed");
    
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Prayer Request Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@   "OK", nil];
    
    [view show];
    
    view = nil;
}


-(void) registerForKeyboardNotifications
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];

}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    

    
    //[activeField setInputAccessoryView:toolbar];
    /*
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // UIEdgeInserts
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    // set the scrollview content insets to the height of the keyboard
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // if active text file is hidden by keyboard, scroll so it's visible
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    if(!CGRectContainsPoint(aRect, activeField.frame.origin))
    {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }*/
}

-(void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *detailsButton = [[UIBarButtonItem alloc] initWithTitle:@"Details" style:UIBarButtonItemStylePlain target:self action:@selector(resignFirstResponder)];
                                      
    UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithTitle:@"Title" style:UIBarButtonItemStylePlain target:self
                                                                    action:@selector(resignFirstResponder)];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:flexButton, titleButton, detailsButton, doneButton, nil];
    
    [toolbar setItems:itemsArray];
    
    [textField setInputAccessoryView:toolbar];
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

-(void) textViewDidBeginEditing:(UITextView *)textView{
    activeField = textView;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    activeField = nil;
}

/*
- (BOOL)findAndResignFirstResponder
{
    BOOL found = NO;
    
    if ( [requestTitle isFirstResponder] ){
        [requestTitle resignFirstResponder];
        found = YES;
    }

    if( [requestDetail isFirstResponder]){
        [requestDetail resignFirstResponder];
        found = YES;
    }
    return found;
}



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    
    
    return YES;
}

-(void) registerForKeyboardNotifications
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
    
}


-(void)keyboardWasShown:(NSNotification *)aNotification
{
    
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    CGFloat h = requestTitle.frame.size.height;
    
    aRect.size.height -= ( kbSize.height + (h/2) );
    // aRect.size.height -= kbSize.height;
    
    // ok we need to figure out how to make this contents of my scroll view move
    // up as the keyboard is displayed
    // [info valueForKey:(NSString *)]
    //[scrollView setContentSize:CGSizeMake]
    
}


-(void) keyboardWillBeHidden:(NSNotification *)aNotification{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}
*/
@end
