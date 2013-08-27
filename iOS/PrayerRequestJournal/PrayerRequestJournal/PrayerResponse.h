//
//  PrayerResponse.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 10/31/12.
//  Copyright (c) 2012 Reuben Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PrayerResponse : NSManagedObject

@property (nonatomic, retain) NSDate * dateEntered;
@property (nonatomic, retain) NSString * disposition;
@property (nonatomic, retain) NSString * response;
@property (nonatomic, retain) NSManagedObject *request;

@end
