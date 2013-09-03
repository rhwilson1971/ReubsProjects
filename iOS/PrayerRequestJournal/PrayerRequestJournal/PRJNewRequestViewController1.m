//
//  PRJNewRequestViewController.m
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 9/2/13.
//  Copyright (c) 2013 Reuben Wilson. All rights reserved.
//

#import "PRJNewRequestViewController1.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath{
    
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    // Configure the cell...
    //[self configureCell:cell atIndexPath:indexPath];
    
    cell.textLabel.text = @"Hi";
    
    return cell;
    
}

@end
