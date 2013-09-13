//
//  PRJNewResponseViewController.m
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 9/10/13.
//  Copyright (c) 2013 Reuben Wilson. All rights reserved.
//

#import "PRJNewResponseViewController.h"

@interface PRJNewResponseViewController (){
    
    NSArray * sections;
    
}

@end

@implementation PRJNewResponseViewController
@synthesize managedObjectContext;
@synthesize dispositionsSegmentedControl;
@synthesize responseDetail;
@synthesize prayerResponse;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
    sections = @[@"Disposition", @"Response"];
    
}

-(void) loadData{

	if( self.prayerResponse != nil )
	{
		
	
	
	
	}
}

-(void) save
{
	//[activeInputView resignFirstResponder];
	
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSError *error = nil;
    
    PrayerResponse * response = nil;
	
	if( nil == prayerResponse ) {
	
		response = (PrayerResponse *)[NSEntityDescription insertNewObjectForEntityForName:@"PrayerResponse" inManagedObjectContext:moc];
		
        response.dateEntered = [NSDate date];
	}
	else {
	
		response = prayerResponse;
	}
    
    //UITextField *textField = (UITextField *) [self.view viewWithTag:kRequestTitleTag];
    //UITextView *textView = (UITextView *) [self.view viewWithTag:kRequestDetailsTag];

    //NSString *requestTitle = [textField text];
    //NSString *requestDetail = [textView text];
    
    //if([requestTitle length] > 0 && [requestDetail length] > 0 ){
		
		response.response  = @"";
		response.disposition = @"";
		//response.dateRequested = dateRequested;
		//pr.requestor = prayerRequestor;
    
        [moc save:&error];
		
        if(nil != error)
        {
            NSLog(@"Error occurred saving prayer request");
        }
        
        NSLog(@"Save button pressed");
    
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Prayer Request Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
        [view show];
    
        view = nil;
    //}
	

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
// #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    switch( [indexPath section])
    {
        case 0:
            [self configureDispositionCell:cell prayerResponse:self.prayerResponse];
            break;
        
        case 1:
            [self configureResponseCell:cell prayerResponse:self.prayerResponse];
            break;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

 -(void) configureResponseCell:(UITableViewCell*)cell prayerResponse:(PrayerResponse*) response
 {
     
     NSArray * dispositions = @[@"Yes, continue", @"No, not for me", @"Waiting"];
     
     
     UISegmentedControl * dispositionSegmentedControl = [[UISegmentedControl alloc] initWithItems:dispositions];
     
     dispositionSegmentedControl.tag = kDispostionTag;
     

     [cell.contentView addSubview:dispositionSegmentedControl];
 }

 -(void) configureDispositionCell:(UITableViewCell*)cell prayerResponse:(PrayerResponse*) response
 {
     UITextView * responseView = [[UITextView alloc] initWithFrame:CGRectMake(5,5,290,100)];
     
     responseView.keyboardType = UIKeyboardTypeDefault;
     responseView.returnKeyType = UIReturnKeyDefault;
     
     responseView.delegate = self;
     responseView.tag = kResponseTag;
     
     UIToolbar *toolbar = [[UIToolbar alloc] init];
     [toolbar setBarStyle:UIBarStyleBlackTranslucent];
     [toolbar sizeToFit];
     
     
     NSArray *itemsArray = @[
                             [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil],
                             [[UIBarButtonItem alloc] initWithTitle:@"Title" style:UIBarButtonItemStylePlain target:self action:@selector(goToTitleField)],
                             [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(goToFinishedEditing)]
                             ];
     
     [toolbar setItems:itemsArray];
     
     [responseView setInputAccessoryView:toolbar];
     
     if( nil != response){
         
         responseView.text = response.response;
     
     }

     [cell.contentView addSubview:responseView];
    
 }

@end
