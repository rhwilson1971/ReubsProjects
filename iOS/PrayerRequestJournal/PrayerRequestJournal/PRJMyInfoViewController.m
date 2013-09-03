//
//  PRJMyInfoViewController.m
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 8/25/13.
//  Copyright (c) 2013 Reuben Wilson. All rights reserved.
//

#import "PRJMyInfoViewController.h"
#import "PrayerRequestor.h"

@interface PRJMyInfoViewController ()

@end


@implementation PRJMyInfoViewController
@synthesize managedObjectContext;
@synthesize FirstName;
@synthesize LastName;
@synthesize Email;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
            self.title = NSLocalizedString(@"My Info", @"My Info");
            // self.tabBarItem.image = [UIImage imageNamed:@"myinfo"];
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
    
    // get existing requestor
    
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSError *error = nil;
    
    NSEntityDescription *entityDescription =
    [NSEntityDescription entityForName:@"PrayerRequestor" inManagedObjectContext:moc];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(LastName="];
    
    [request setEntity:entityDescription];
    
    NSArray * items = [moc executeFetchRequest:request error:&error];
    
    if(nil != error)
    {
        NSLog(@"Error occurred fetching prayer requestor");
    }
    
    if([items count] != 0)
    {
        NSManagedObject *prayerRequestor = [items objectAtIndex:0];
        
        FirstName.text = [prayerRequestor valueForKey:@"FirstName"];
         
        LastName.text = [prayerRequestor valueForKey:@"LastName"];
        
        Email.text = [prayerRequestor valueForKey:@"Email"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)save:(id)sender{

    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSError *error = nil;
    
    // find existing user
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PrayerRequestor" inManagedObjectContext:moc];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    
    NSArray * items = [moc executeFetchRequest:request error:&error];
    NSManagedObject *prayerRequestor;
    if(nil != error)
    {
        NSLog(@"Error occurred fetching prayer requestor");
    }
    
    if([items count] == 0)
    {
        prayerRequestor = [NSEntityDescription insertNewObjectForEntityForName:@"PrayerRequestor" inManagedObjectContext:moc];
    }
    else
    {
        prayerRequestor = [items objectAtIndex:0];
    }
    
    [prayerRequestor setValue:FirstName.text forKey:@"FirstName"];
    [prayerRequestor setValue:LastName.text forKey:@"LastName"];
    [prayerRequestor setValue:Email.text forKey:@"Email"];
    
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
@end
