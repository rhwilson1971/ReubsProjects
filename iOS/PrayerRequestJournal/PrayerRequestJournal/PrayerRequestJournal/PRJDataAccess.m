//
//  PRJDataAccess.m
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 11/1/12.
//  Copyright (c) 2012 Reuben Wilson. All rights reserved.
//

#import "PRJDataAccess.h"

@implementation PRJDataAccess
@synthesize prayerRequests;
@synthesize managedObjectContext=_managedObjectContext;

-(NSInteger) numberOfItems {
    return [prayerRequests count];
}

-(void) initialize {
    
    
    
    
    
    //NSManagedObjectModel * model = [[_managedObjectContext persistentStoreCoordinator] managedObjectContext];
    
    
    
}


@end
