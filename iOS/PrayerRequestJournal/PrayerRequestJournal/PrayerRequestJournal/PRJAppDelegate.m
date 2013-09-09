//
//  PRJAppDelegate.m
//  PrayerRequestJournal
//
//  Created by Reuben Wilson on 10/24/12.
//  Copyright (c) 2012 Reuben Wilson. All rights reserved.
//

#import "PRJAppDelegate.h"

#import "PRJAllRequestsViewController.h"

#import "PRJNewRequestViewController.h"
#import "PRJShareViewController.h"
#import "PRJMyInfoViewController.h"
#import "PRJNewRequestViewController1.h"

@implementation PRJAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    PRJAllRequestsViewController *vcRequests =
        [[PRJAllRequestsViewController alloc] initWithNibName:@"PRJAllRequestsViewController" bundle:nil];
    
    PRJNewRequestViewController1 *vcRequest =
        [[PRJNewRequestViewController1 alloc] initWithNibName:@"PRJNewRequestViewController1" bundle:nil];
    PRJShareViewController *vcShare =
        [[PRJShareViewController alloc] initWithNibName:@"PRJShareViewController" bundle:nil];
    PRJMyInfoViewController *vcInfo =
        [[PRJMyInfoViewController alloc] initWithNibName:@"PRJMyInfoViewController" bundle:nil];
    
    
    NSArray *tabBarControllers = @[
    [[UINavigationController alloc] initWithRootViewController:vcRequests],
    [[UINavigationController alloc] initWithRootViewController:vcRequest],
    [[UINavigationController alloc] initWithRootViewController:vcShare],
    [[UINavigationController alloc] initWithRootViewController:vcInfo]];
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = tabBarControllers;
    
    vcRequests.managedObjectContext = self.managedObjectContext;
    vcRequest.managedObjectContext = self.managedObjectContext;
    vcInfo.managedObjectContext = self.managedObjectContext;
    
    // pass over to the second view controller also, ok!
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (PrayerRequestor*) currentPrayerRequestor
{
    PrayerRequestor * requestor=nil;
    
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSError *error = nil;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PrayerRequestor" inManagedObjectContext:moc];
    
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
        
        requestor = [[PrayerRequestor init] alloc];
        
        
    
        requestor.lastName = [prayerRequestor valueForKey:@"Firstname"];
        requestor.firstName = [prayerRequestor valueForKey:@"LastName"];
        requestor.email = [prayerRequestor valueForKey:@"Email"];
        // requestor.r= [prayerRequestor valueForKey:@"Email"];
    
    }

    
    
    return requestor;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if(managedObjectContext!=nil){
        if([managedObjectContext hasChanges] && ![managedObjectContext save:&error]){
            NSLog(@"Unresolve error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

#pragma mark - Core Data stack
- (NSManagedObjectContext *)managedObjectContext {
    
    if(_managedObjectContext != nil){
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(coordinator != nil){
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}

-(NSManagedObjectModel *)managedObjectModel{
    
    if(_managedObjectModel!=nil){
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PRJDataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
    
}

// Returns the persisten store coordinate store coordinator for the application
// If the coordinator doesn't already exist, it is created and the application's store added to it
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    
    if(_persistentStoreCoordinator != nil){
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PRJDataModel.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self
                                                                                                    managedObjectModel]];
    
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        
        NSLog(@"unresolved error %@ %@", error, [error userInfo]);
        
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's documents directory
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
