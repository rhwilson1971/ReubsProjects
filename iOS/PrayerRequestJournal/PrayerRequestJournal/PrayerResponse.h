//
//  PrayerResponse.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 9/24/13.
//  Copyright (c) 2013 Reuben Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PrayerRequest;

@interface PrayerResponse : NSManagedObject

@property (nonatomic, retain) NSDate * dateEntered;
@property (nonatomic, retain) NSString * disposition;
@property (nonatomic, retain) NSString * response;
@property (nonatomic, retain) NSNumber * responseId;
@property (nonatomic, retain) NSNumber * confidenceFactor;
@property (nonatomic, retain) PrayerRequest *request;

@end
