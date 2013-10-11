//
//  PRJNewRequestViewController.m
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 9/2/13.
//  Copyright (c) 2013 Reuben Wilson. All rights reserved.
//

#import "PRJNewRequestViewController1.h"
#import "PrayerRequest.h"

@interface PRJNewRequestViewController1 ()
{
    UIView * activeInputView;
}

@end

@implementation PRJNewRequestViewController1

@synthesize managedObjectContext;
@synthesize prayerRequestor;
@synthesize prayerRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
        // Custom initialization
        self.title = NSLocalizedString(@"New", @"New");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain
                                                                  target:self action:@selector(save:)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    if( self.prayerRequest == nil){
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain
                                                                    target:self action:@selector(cancel:)];
        self.navigationItem.leftBarButtonItem = cancelButton;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Keyboard notifications, not needed at the moment, since using uitableview controller
-(void) registerForKeyboardNotifications{
    
}

-(void) keyboardWasShown:(NSNotification*) aNotification
{
    
}

-(void) keyboardWillBeHidden:(NSNotification *) aNotification
{
    
}

#pragma mark - Actions handled by this controller

// Method called when the user presses the save button
- (void) save:(id)sender
{

    [activeInputView resignFirstResponder];
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSError *error = nil;
    
    PrayerRequest * pr = nil;
    
    NSDate *dateRequested = [NSDate date];
	
	if( nil == prayerRequest ) 
	{
		pr = (PrayerRequest *)[NSEntityDescription insertNewObjectForEntityForName:@"PrayerRequest" inManagedObjectContext:moc];
	}
	else 
	{
		pr = self.prayerRequest;
	}
    
    UITextField *textField = (UITextField *) [self.view viewWithTag:kRequestTitleTag];
    UITextView *textView = (UITextView *) [self.view viewWithTag:kRequestDetailsTag];

    NSString *requestTitle = [textField text];
    NSString *requestDetail = [textView text];
    
    if([requestTitle length] > 0 && [requestDetail length] > 0 )
	{
		pr.title  = requestTitle;
		pr.detail = requestDetail;
		pr.dateRequested = dateRequested;
		pr.requestor = prayerRequestor;
    
        [moc save:&error];
		
        if(nil != error)
        {
            NSLog(@"Error occurred saving prayer request");
        }
        
        NSLog(@"Save button pressed");
    
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Prayer Request Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
        [view show];
    
        view = nil;
    }
}

-(void) cancel:(id)sender
{
    [activeInputView resignFirstResponder];
    
    UITextView *detailsView = (UITextView *)[self.view viewWithTag:kRequestDetailsTag];
    UITextField *titleView = (UITextField *)[self.view viewWithTag:kRequestTitleTag];
    
    detailsView.text = @"";
    titleView.text = @"";
}

#pragma mark - TextField delegate methods
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"Text field did begin editing");
    activeInputView=textField;
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"Text field did end editing");
    activeInputView=nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    int previousTag = textField.tag; // current field
    
    if( previousTag == kRequestTitleTag)
    {
        UITextView *view = (UITextView *)[self.view viewWithTag:kRequestDetailsTag];
        [view becomeFirstResponder];
    }

    return YES;
}

#pragma mark - TextView delegate methods

-(void) textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"textView did begin editing");
    activeInputView=textView;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"Text did end editing");
    activeInputView=nil;
}

#pragma mark - Table view data source & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{    
    return kInputSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return kInputRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath{
    
    NSInteger section = [indexPath section];
    
    static NSString *CellIdentifier = @"PrayerRequestCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        if( kRequestTitleSection == section){
            
            UITextField * requestTitle = [[UITextField alloc] initWithFrame:CGRectMake(5,5,290,30)];
            
            requestTitle.keyboardType = UIKeyboardTypeDefault;
            requestTitle.returnKeyType = UIReturnKeyNext;
            
            requestTitle.delegate = self;
            requestTitle.tag = kRequestTitleTag;
            requestTitle.placeholder = @"prayer request description";
            requestTitle.clearButtonMode = UITextFieldViewModeWhileEditing;
			if( nil != self.prayerRequest ) {
				requestTitle.text = self.prayerRequest.title;
			}
            [cell.contentView addSubview:requestTitle];
            
        }
		
        if( kRequestDetailSection == section){
            
            UITextView * requestDetails = [[UITextView alloc] initWithFrame:CGRectMake(5,5,290,100)];
            
            requestDetails.keyboardType = UIKeyboardTypeDefault;
            requestDetails.returnKeyType = UIReturnKeyDefault;
            
            requestDetails.delegate = self;
            requestDetails.tag = kRequestDetailsTag;
            
            UIToolbar *toolbar = [[UIToolbar alloc] init];
            [toolbar setBarStyle:UIBarStyleBlackTranslucent];
            [toolbar sizeToFit];
            
            
            NSArray *itemsArray = @[
                                    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil],
                                    [[UIBarButtonItem alloc] initWithTitle:@"Title" style:UIBarButtonItemStylePlain target:self action:@selector(goToTitleField)],
                                    [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(goToFinishedEditing)]
                                    ];
            
            [toolbar setItems:itemsArray];
            
            [requestDetails setInputAccessoryView:toolbar];
			
			if( nil != self.prayerRequest ){
				requestDetails.text = self.prayerRequest.detail;
			}
            
            [cell.contentView addSubview:requestDetails];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellHeight = 40.0;
    
    if( [indexPath section] == kRequestDetailSection ){
        cellHeight = 200.0;
    }
    
    return cellHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
	
    switch (section)
    {
        case kRequestTitleSection:
            sectionName = NSLocalizedString(@"Prayer Request Title", @"Prayer Request Title");
            break;
        case kRequestDetailSection:
            sectionName = NSLocalizedString(@"Prayer Request Details", @"Prayer Request Details");
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

-(void) goToTitleField{
    
    UITextField *titleView = (UITextField *)[self.view viewWithTag:kRequestTitleTag];
    [titleView becomeFirstResponder];
    
}

-(void) goToFinishedEditing{
    
    UITextView *detailsView = (UITextView *)[self.view viewWithTag:kRequestDetailsTag];
    [detailsView resignFirstResponder];
}

@end
