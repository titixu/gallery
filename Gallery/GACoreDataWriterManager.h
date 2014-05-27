//
//  GACoreDataWriterManager.h
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GACoreDataWriterManager : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


+(instancetype)sharedManager;
-(void)writeToCoreDataWithDictionary:(NSDictionary *)dictionary;
- (void)saveContext;
@end
