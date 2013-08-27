//
//  PRJDataAccess.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 11/1/12.
//  Copyright (c) 2012 Reuben Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRJDataAccess : NSObject {
    
}

@property (nonatomic, strong) NSMutableArray* prayerRequests;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;


-(NSInteger) numberOfItems;
-(void) initialize ;

@end
