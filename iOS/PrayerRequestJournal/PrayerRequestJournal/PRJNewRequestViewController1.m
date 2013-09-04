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

@end


@implementation PRJNewRequestViewController1

@synthesize managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain
                                                                    target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = saveButton;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) registerForKeyboardNotifications{
    
}

-(void) keyboardWasShown:(NSNotification*) aNotification{
    
}

-(void) keyboardWillBeHidden:(NSNotification *) aNotification{
    
}


- (void) save:(id)sender{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSManagedObject *prayerRequestObject;
    
    NSError *error = nil;
    
    prayerRequestObject = [NSEntityDescription insertNewObjectForEntityForName:@"PrayerRequest" inManagedObjectContext:moc];
    
    
    NSDate *dateRequested = [NSDate date];
    
    NSString *requestTitle = @"Title Placeholder";
    NSString *requestDetail = @"Detail Placeholder";
    
    [prayerRequestObject setValue:requestTitle forKey:@"title"];
    [prayerRequestObject setValue:requestDetail forKey:@"detail"];
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

-(void) cancel:(id)sender{
    
}

#pragma mark - TextField delegate methods
-(void) textFieldDidBeginEditing:(UITextField *)textField{
    
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(currentSelection){
        currentSelection = [NSIndexPath indexPathForRow:currentSelection.row+1 inSection:currentSelection.section];
    }
    else {
        currentSelection = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    
    [self.tableView selectRowAtIndexPath:currentSelection animated:YES scrollPosition: UITableViewScrollPositionTop];

    return YES;
}


#pragma mark - TextView delegate methods

-(void) textViewDidBeginEditing:(UITextView *)textView{
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
}

#pragma mark - Table view data source & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath{
    
    NSInteger section = [indexPath section];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        if( 0 == section){
            
            UITextField * requestTitle = [[UITextField alloc] initWithFrame:CGRectMake(5,5,185,30)];
            
            requestTitle.keyboardType = UIKeyboardTypeDefault;
            requestTitle.returnKeyType = UIReturnKeyNext;
            
            requestTitle.delegate = self;
            
            
            [cell.contentView addSubview:requestTitle];
            
        }
        if( 1 == section){
            
            UITextView * requestDetails = [[UITextView alloc] initWithFrame:CGRectMake(5,5,290,100)];
            
            requestDetails.keyboardType = UIKeyboardTypeDefault;
            requestDetails.returnKeyType = UIReturnKeyDone;
            
            requestDetails.delegate = self;
            
            [cell.contentView addSubview:requestDetails];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellHeight = 30.0;
    
    if( [indexPath section] == 1 ){
        cellHeight = 200.0;
    }
    
    return cellHeight;
}

NSIndexPath *currentSelection;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    currentSelection = indexPath;
}

@end
