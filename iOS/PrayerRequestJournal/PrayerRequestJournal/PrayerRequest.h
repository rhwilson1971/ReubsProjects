//
//  PrayerRequest.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 10/31/12.
//  Copyright (c) 2012 Reuben Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PrayerRequestor, PrayerResponse;

@interface PrayerRequest : NSManagedObject

@property (nonatomic, retain) NSDate * dateAnswered;
@property (nonatomic, retain) NSDate * dateRequested;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) PrayerRequestor *requestor;
@property (nonatomic, retain) NSSet *responses;
@end

@interface PrayerRequest (CoreDataGeneratedAccessors)

- (void)addResponsesObject:(PrayerResponse *)value;
- (void)removeResponsesObject:(PrayerResponse *)value;
- (void)addResponses:(NSSet *)values;
- (void)removeResponses:(NSSet *)values;

@end
