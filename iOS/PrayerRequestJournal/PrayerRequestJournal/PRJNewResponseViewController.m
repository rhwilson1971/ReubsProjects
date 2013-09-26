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
    UISegmentedControl * segControl;
}

@end

@implementation PRJNewResponseViewController
@synthesize managedObjectContext;
@synthesize prayerResponse;
@synthesize prayerRequest;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
	{
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
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    // [self loadData];
}

- (void) loadDisposition: (UISegmentedControl *)segmentedControl
{
    if( self.prayerResponse != nil)
	{
        
        if( [self.prayerResponse.response compare:@"No"] == 0 )
		{
            [segmentedControl setSelectedSegmentIndex:0];
        }
        else if ( [self.prayerResponse.response compare:@"Yes"] == 0)
		{
            [segmentedControl setSelectedSegmentIndex:1];
        }
        else if ( [self.prayerResponse.response compare:@"Waiting"] == 0 )
		{
            [segmentedControl setSelectedSegmentIndex:2];
        }
    }
}

-(void) loadData{
    UISegmentedControl * segControlDisposition = (UISegmentedControl *)[self.view viewWithTag:kDispostionTag];
    UITextView * responseTextView = (UITextView *)[self.view viewWithTag:kResponseTag];
    
    if(nil == segControlDisposition || nil == responseTextView)
	{
        return ;
    }
    
	if( self.prayerResponse != nil )
	{
        if( [self.prayerResponse.response compare:@"No"] == 0 )
		{
            [segControlDisposition setSelectedSegmentIndex:0];
        }
        else if ( [self.prayerResponse.response compare:@"Yes"] == 0)
		{
            [segControlDisposition setSelectedSegmentIndex:1];
        }
        else if ( [self.prayerResponse.response compare:@"Waiting"] == 0 )
		{
            [segControlDisposition setSelectedSegmentIndex:2];
        }
        
        responseTextView.text = self.prayerResponse.response;
	}
}

-(void) save:(id) sender 
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSError *error = nil;
    
    PrayerResponse * response = nil;
	
	if( nil == prayerResponse ) 
	{
		// this is failing currently
		response = (PrayerResponse *)[NSEntityDescription insertNewObjectForEntityForName:@"PrayerResponse" inManagedObjectContext:moc];
        response.dateEntered = [NSDate date];
        response.request = prayerRequest;
	}
	else 
	{
		response = prayerResponse;
	}
    
    UITextView * textView = (UITextView *)[self.view viewWithTag:kResponseTag];
    UISegmentedControl * segControl1 = (UISegmentedControl *)[self.view viewWithTag:kDispostionTag];

    response.response  = [textView text];
    NSInteger index = [segControl1 selectedSegmentIndex];

    if( index == 0 )
	{
        response.disposition = @"Yes";
    }
	else if (index == 1 )
	{
        response.disposition = @"No";
    }
    else{
        response.disposition = @"Waiting";
    }
    
    [moc save:&error];
		
    if(nil != error){
        NSLog(@"Error occurred saving prayer request");
    }
        
    NSLog(@"Save button pressed");
    
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Prayer Request Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [view show];
    
    view = nil;
    
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
    switch([indexPath section])
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
    if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) 
	{
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

-(CGFloat)tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 40.0;
    
    if( [indexPath section] == 1 )
	{
        cellHeight = 150.0;
    }
    
    return cellHeight;
}

 -(void) configureDispositionCell:(UITableViewCell*)cell prayerResponse:(PrayerResponse*) response
 {
     
     NSArray * dispositions = @[@"Yes, continue", @"No, not for me", @"Waiting"];
     
     UISegmentedControl * dispositionSegmentedControl = [[UISegmentedControl alloc] initWithItems:dispositions];
     
     [dispositionSegmentedControl setSelectedSegmentIndex:1];
     
     dispositionSegmentedControl.tag = kDispostionTag;
     
     UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5,5,320,20)];
     [view addSubview:dispositionSegmentedControl];
     [self loadDisposition:dispositionSegmentedControl];
     
     [cell.contentView addSubview:view];
 }

 -(void) configureResponseCell:(UITableViewCell*)cell prayerResponse:(PrayerResponse*) response
 {
     UITextView * responseView = [[UITextView alloc] initWithFrame:CGRectMake(1,1,290,145)];
     
     responseView.keyboardType = UIKeyboardTypeDefault;
     responseView.returnKeyType = UIReturnKeyDefault;
     
     responseView.delegate = self;
     responseView.tag = kResponseTag;
     
     [responseView setInputAccessoryView:[self keyboardToolBar]];
     
     if( nil != response){
         responseView.text = response.response;
     }
     
     [cell.contentView addSubview:responseView];
 }

- (UIToolbar *)keyboardToolBar 
{
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    
    [toolbar setBarStyle:UIBarStyleDefault];
    [toolbar sizeToFit];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(moveFocusToDisposition:)];
    
    
    
    
    // [nextButton setTintColor: [UIColor lightGrayColor]];
    
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard:)];
    
    NSArray *itemsArray = @[nextButton, flexButton, doneButton];
    
    [toolbar setItems:itemsArray];
    
    return toolbar;
}

- (void) moveFocusToDisposition:(id)sender 
{
    UISegmentedControl * dispositionView = (UISegmentedControl *)[self.view viewWithTag:kDispostionTag];
    UITextView * responseView = (UITextView *)[self.view viewWithTag:kResponseTag];
    
    [responseView resignFirstResponder];
    [dispositionView becomeFirstResponder];
}

- (void) resignKeyboard:(id)sender
{
    
    UITextView * responseView = (UITextView *)[self.view viewWithTag:kResponseTag];
    
    [responseView resignFirstResponder];
}


/*

- (UIToolbar *)keyboardToolBar3 
{
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleDefault];
    [toolbar sizeToFit];  // UIBarStyleBlackTranslucent
    
    segControl = [[UISegmentedControl alloc] initWithItems:@[@"Previous", @"Next", @"Done"]];
    [segControl setSegmentedControlStyle:UIBarButtonSystemItemAction];
    segControl.momentary = YES;
    
    [segControl addTarget:self action:@selector(changeRow:) forControlEvents:(UIControlEventValueChanged)];
    [segControl setEnabled:NO forSegmentAtIndex:0];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithCustomView:segControl];
    // UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithCustomView:segControl];
    
    // NSArray *itemsArray = @[previousButton, nextButton];
    NSArray *itemsArray = @[nextButton];
    [toolbar setItems:itemsArray];
    
    return toolbar;
}

- (void)changeRow:(id)sender 
{
    
    int index = [sender selectedSegmentIndex];
    
    switch (index) 
	{
        case 1:
        {
            UITextView *textView = (UITextView *) [self.view viewWithTag:kResponseTag];
            
            [textView resignFirstResponder];
            
            UISegmentedControl * dispositionSegmentedControl = (UISegmentedControl *)[self.view viewWithTag:kDispostionTag];
            [dispositionSegmentedControl becomeFirstResponder];
        }
        break;
            
    default:
        break;
    }
}
*/

@end
