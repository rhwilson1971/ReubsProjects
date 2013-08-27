//
//  PrayerRequestor.h
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 10/31/12.
//  Copyright (c) 2012 Reuben Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PrayerRequestor : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * facebook;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * isAdmin;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *requests;
@end

@interface PrayerRequestor (CoreDataGeneratedAccessors)

- (void)addRequestsObject:(NSManagedObject *)value;
- (void)removeRequestsObject:(NSManagedObject *)value;
- (void)addRequests:(NSSet *)values;
- (void)removeRequests:(NSSet *)values;

@end
