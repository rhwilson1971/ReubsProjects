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
	NSArray *responseViewSections;
	NSArray *prayerResponses;
}

@end

@implementation PRJResponsesViewController
@synthesize managedObjectContext;
@synthesize currentPrayerRequest;

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

    self.title = NSLocalizedString(@"Prayer Request Detail", @"Prayer Request Detail");
    
	responseViewSections = @[@"Prayer Request", @"Recent Responses"];
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Answer"
                                                                              style:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods for this view controller


- (void) add:(id)sender
{
    
	// treat this as a brand new prayer response
    PRJNewResponseViewController * nrvc = [[PRJNewResponseViewController alloc] initWithNibName:@"PRJNewResponseViewController" bundle:nil];
	
	nrvc.prayerResponse = nil;
	nrvc.prayerRequest = self.currentPrayerRequest;
    nrvc.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:nrvc animated:YES];
}


-(void) loadData
{
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"dateEntered"
                                        ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
    
    prayerResponses = [[currentPrayerRequest.responses allObjects]
                                 sortedArrayUsingDescriptors:sortDescriptors];
    
    // currentPrayerRequest.responses
    // prayerResponses = [currentPrayerRequest.responses allObjects];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [responseViewSections count];
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
    if (cell == nil) 
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
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
			PrayerResponse *response = [prayerResponses objectAtIndex:indexPath.row];
			
			[self configureResponseCell:cell prayerResponse:response];
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
            vc.managedObjectContext = [self managedObjectContext];
			vc.prayerRequest = currentPrayerRequest;
		    
			detailViewController = vc;
		}
		break;
		
		case kResponseSection:
		{
			PRJNewResponseViewController *vc = [[PRJNewResponseViewController alloc] initWithNibName:@"PRJNewResponseViewController" bundle:nil];
			
			PrayerResponse * prayerResponse = [prayerResponses objectAtIndex:indexPath.row];
			
			// Pass the prayer request object to view controller
			vc.prayerResponse = prayerResponse;
            vc.managedObjectContext = [self managedObjectContext];
			vc.prayerRequest = (PrayerRequest *)prayerResponse.request;
			
			detailViewController = vc;
		}
		break;
	}
	
	if(nil != detailViewController )
	{
		// Push the view controller.
		[self.navigationController pushViewController:detailViewController animated:YES];
	}
}

#pragma mark - Cell Configuration 
 
 -(void) configureResponseCell:(UITableViewCell*)cell prayerResponse:(PrayerResponse*)prayerResponse
 {
     cell.textLabel.text = prayerResponse.disposition;
     
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"EEE, MMM d, ''yy"];
     
     //Optionally for time zone converstions
     [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
     //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     //[dateFormatter setDateFormat:@"EEE, MMM d, ''yy"];
     
     NSString *formattedDateString = [formatter stringFromDate:prayerResponse.dateEntered];
     NSLog(@"formattedDateString: %@", formattedDateString);
     
     //cell.detailTextLabel.text = formattedDateString;
     
     cell.detailTextLabel.text = [self getMyDate:prayerResponse.dateEntered];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 }
 
-(void) configureRequestCell:(UITableViewCell*)cell prayerRequest:(PrayerRequest *)prayerRequest
{
	cell.textLabel.text = prayerRequest.title;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE, MMM d, ''yy"];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString *stringFromDate = [formatter stringFromDate:prayerRequest.dateRequested];
    NSLog(@"formatted String: %@", stringFromDate);
    
    // cell.detailTextLabel.text = stringFromDate;
    cell.detailTextLabel.text = [self getMyDate:prayerRequest.dateRequested];
    
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

-(NSString *) getMyDate:(NSDate *) myDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:frLocale];
    
    [dateFormatter setDoesRelativeDateFormatting:YES];
    
    //NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60*60*24*3];
    NSString *dateString = [dateFormatter stringFromDate:myDate];
    
    NSLog(@"dateString: %@", dateString);
    
    return dateString;
}

@end
