//
//  GACoreDataWriterManager.m
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GACoreDataWriterManager.h"
#import "GAGalleryMO+Addition.h"

@implementation GACoreDataWriterManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


+(instancetype)sharedManager {
    static GACoreDataWriterManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GACoreDataWriterManager alloc] init];
    });
    return manager;
}

-(void)writeToCoreDataWithDictionary:(NSDictionary *)dictionary {
    NSArray *galleries = [dictionary arrayWithKey:@"galleries"];
    for (NSDictionary *galleryDict in galleries) {
        [GAGalleryMO storeGalleryWithDictionary:galleryDict atContext:self.managedObjectContext];
    }
    [self saveContext];
}


#pragma mark - CoreData methods
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GAMainModel" withExtension:@"mom"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    if (!_managedObjectModel) {
        modelURL = [[NSBundle mainBundle] URLForResource:@"GAMainModel" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationLibraryDirectory] URLByAppendingPathComponent:@"GAMainModel.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES, NSInferMappingModelAutomaticallyOption : @YES};
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        
        if (error) {
            NSLog(@"error %@", error);
        }
        
        //Light weight CoreData immigration failed
        //Drap the dqlite file and create new one, all user data will be removed
        
        [[[UIAlertView alloc] initWithTitle:@"System Error!" message:@"Reseting local data base, if problem persisted please delete this application and re-install it from App Store" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        
        NSArray *stores = [_persistentStoreCoordinator persistentStores];
        for (NSPersistentStore *store in stores) {
            [_persistentStoreCoordinator removePersistentStore:store error:NULL];
        }
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
        
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            
            if (error) {
                NSLog(@"error %@", error);
            }
            
            [[[UIAlertView alloc] initWithTitle:error.localizedDescription message:error.localizedFailureReason delegate:self cancelButtonTitle:@"Abort Applciation" otherButtonTitles: nil]show];
            
            NSLog(@"Should not be able to get to here");
        }
        
        
    }
    
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationLibraryDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}
@end
