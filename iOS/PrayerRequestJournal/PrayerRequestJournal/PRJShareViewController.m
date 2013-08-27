//
//  PRJShareViewController.m
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 11/11/12.
//  Copyright (c) 2012 Reuben Wilson. All rights reserved.
//

#import "PRJShareViewController.h"

@interface PRJShareViewController ()

@end

@implementation PRJShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Share", @"Share");
        self.tabBarItem.image = [UIImage imageNamed:@"share30x30"];
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

@end
