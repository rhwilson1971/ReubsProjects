//
//  PRJResponsesViewController.m
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 9/6/13.
//  Copyright (c) 2013 Reuben Wilson. All rights reserved.
//

#import "PRJResponsesViewController.h"
#import "PRJNewRequestViewController1.h"
#import "PRJNewResponseViewCOntroller.h"

@interface PRJResponsesViewController ()
{
	NSArray *responsesSections;
	NSArray *prayerResponses;
}

@end

@implementation PRJResponsesViewController
@synthesize managedObjectContext;
@synthesize currentPrayerRequest;

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

    self.title = NSLocalizedString(@"Prayer Request Detail", @"Prayer Request Detail");
    responsesSections = @[@"Prayer Request", @"Recent Responses"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Answer"
                                                                              style:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) add:(id)sender{
    
    PRJNewResponseViewController * nrvc = [[PRJNewResponseViewController alloc] initWithNibName:@"PRJNewResponseViewController" bundle:nil];
    
    [self.navigationController pushViewController:nrvc animated:YES];
}



#pragma mark - Prayer request data method
-(void) loadData
{
    // currentPrayerRequest.responses
    prayerResponses = [currentPrayerRequest.responses allObjects];
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [responsesSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows=0;
	
	switch( section )
	{
		case kRequestSection:
        {
			rows = 1;
			break;
		}
		
		case kResponseSection:
		{
			rows = [prayerResponses count];
			break;
		}
	}
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	NSInteger section = [indexPath section];
	
	switch( section )
	{
		case kRequestSection:
		{
            
			[self configureRequestCell:cell prayerRequest:currentPrayerRequest];
		}
		break;
		
		case kResponseSection:
		{
			
			PrayerResponse *pr = [prayerResponses objectAtIndex:indexPath.row];
			
			[self configureResponseCell:cell prayerResponse:pr];
			
		}
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
	
	UIViewController *detailViewController = nil;
	
	switch( [indexPath section] )
	{
		case kRequestSection:
		{
			PRJNewRequestViewController1 *vc = [[PRJNewRequestViewController1 alloc] initWithNibName:@"PRJNewRequestViewController1" bundle:nil];
			
			// Pass the selected object to the new view controller.
			vc.prayerRequest = currentPrayerRequest;
			
			detailViewController = vc;
		}
		break;
		
		case kResponseSection:
		{
			PRJNewResponseViewController *vc = [[PRJNewResponseViewController alloc] initWithNibName:@"PRJNewResponseViewController" bundle:nil];
			
			PrayerResponse * prayerResponse = [prayerResponses objectAtIndex:indexPath.row];
			
			// Pass the selected object to the new view controller.
			vc.prayerResponse = prayerResponse;
			
			detailViewController = vc;
			
		}
		break;
	}
	
	if(nil != detailViewController ){
	
		// Push the view controller.
		[self.navigationController pushViewController:detailViewController animated:YES];
	}
}
 
*/

#pragma mark - Cell Configuration 
 -(void) configureResponseCell:(UITableViewCell*)cell prayerResponse:(PrayerResponse*)prayerResponse{
     cell.textLabel.text = prayerResponse.disposition;
     
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"yyyy"];
     
     //Optionally for time zone converstions
     [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
     
     NSString *stringFromDate = [formatter stringFromDate:prayerResponse.dateEntered];

     cell.detailTextLabel.text = stringFromDate;
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 }
 
-(void) configureRequestCell:(UITableViewCell*)cell prayerRequest:(PrayerRequest *)prayerRequest{
	cell.textLabel.text = prayerRequest.title;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString *stringFromDate = [formatter stringFromDate:prayerRequest.dateRequested];
    
    cell.detailTextLabel.text = stringFromDate;

	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }
 

@end
