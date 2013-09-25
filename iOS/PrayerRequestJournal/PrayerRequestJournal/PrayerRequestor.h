//
//  PrayerRequestor.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 9/24/13.
//  Copyright (c) 2013 Reuben Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PrayerRequest;

@interface PrayerRequestor : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * facebook;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * isAdmin;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * requestorId;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *requests;
@end

@interface PrayerRequestor (CoreDataGeneratedAccessors)

- (void)addRequestsObject:(PrayerRequest *)value;
- (void)removeRequestsObject:(PrayerRequest *)value;
- (void)addRequests:(NSSet *)values;
- (void)removeRequests:(NSSet *)values;

@end
