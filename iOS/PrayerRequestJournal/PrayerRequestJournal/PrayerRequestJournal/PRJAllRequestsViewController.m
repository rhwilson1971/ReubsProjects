//
//  PRJAllRequestsViewController.m
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 10/24/12.
//  Copyright (c) 2012 Reuben Wilson. All rights reserved.
//

#import "PRJResponsesViewController.h"
#import "PRJAllRequestsViewController.h"
#import "PrayerRequest.h"

@interface PRJAllRequestsViewController () 
{
	NSMutableArray *prayerRequests;
}

@end

@implementation PRJAllRequestsViewController

@synthesize MyPrayerRequestor;
@synthesize managedObjectContext;


#pragma mark -
#pragma mark View controller methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
        self.title = NSLocalizedString(@"Prayer Requests", @"Prayer Requests");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
	
	
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)viewWillAppear:(BOOL)animated {
    
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PrayerRequest" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateRequested" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    prayerRequests = [[NSMutableArray alloc] initWithArray:array];
    
    [self.tableView reloadData];
    
    if( nil != error )
    {
        NSLog(@"Error occurred fetching from db %@", [error description]);
        exit(-1);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Data Access Methods (internal)
-(void) removePrayerRequest:(PrayerRequest *) prayerRequest{

    if( nil != prayerRequest){
        
        NSError *error;
    
        [managedObjectContext deleteObject:prayerRequest];
    
        [managedObjectContext save:&error];
    
        if(nil != error)
        {
            NSLog(@"Error occurred saving prayer request");
        }
    }
}


#pragma mark -
#pragma mark Table view data source and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [prayerRequests count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId=@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    
    PrayerRequest *request = [prayerRequests objectAtIndex:indexPath.row];
    
    [self configureRequestCell:cell withRequest:request];
	
    return cell;
}

-(void) configureRequestCell:(UITableViewCell*)cell withRequest:(PrayerRequest *)prayerRequest
{
	// Get last response 
	if( nil != prayerRequest.responses )
	{
		
	}
	
	NSString * dateAsString = [prayerRequest.dateRequested description];
	
	cell.textLabel.text = prayerRequest.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"As of %@ I'm waiting for response", dateAsString];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {
        PrayerRequest * requestToDelete = [prayerRequests objectAtIndex:indexPath.row];
        
        [self removePrayerRequest:requestToDelete];
        
        [prayerRequests removeObjectAtIndex:indexPath.row];
    }
    [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PrayerRequest * prayerRequest = [prayerRequests objectAtIndex:indexPath.row];
    
    PRJResponsesViewController *vc = [[PRJResponsesViewController alloc] initWithNibName:@"PRJResponsesViewController" bundle:nil];
    
    vc.currentPrayerRequest = prayerRequest;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
