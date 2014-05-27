//
//  GAGalleryMO+Addition.m
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GAGalleryMO+Addition.h"
#import "GAArtItemMO+Addition.h"
#define entityName @"Gallery"

@implementation GAGalleryMO (Addition)

+(void)storeGalleryWithDictionary:(NSDictionary *)dataDictionary atContext:(NSManagedObjectContext *)context {
    
    NSString *galleryID = [dataDictionary stringWithKey:@"id"];
    
    GAGalleryMO *galleryMO = [GAGalleryMO galleryMOWithID:galleryID atContext:context];
                              
    galleryMO.streetName = [dataDictionary stringWithKey:@"address"];
    galleryMO.postcode = [dataDictionary stringWithKey:@"postcode"];
    galleryMO.suburb = [dataDictionary stringWithKey:@"suburb"];
    galleryMO.state = [dataDictionary stringWithKey:@"state"];
    galleryMO.lon = [dataDictionary stringWithKey:@"lon"];
    galleryMO.lat = [dataDictionary stringWithKey:@"lat"];
    
    NSString *numberOfArtItem = [dataDictionary stringWithKey:@"piecesofart"];
    
    for (NSInteger i = 0; i<numberOfArtItem.integerValue; i++) {
        //no art info provent with API, create a fake name here
        NSString *fakeName = [NSString stringWithFormat:@"%@ - %i", galleryID, i];
        [GAArtItemMO storeWithName:fakeName forGallerMO:galleryMO];
    }
}

+(GAGalleryMO *)galleryMOWithID:(NSString *)idString atContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"galleryID = %@", idString];
    
    request.predicate = predicate;
    
    NSError *error = nil;
    
    NSArray *resultArray = [context executeFetchRequest:request error:&error];
    
    GAGalleryMO *galleryMO = resultArray.lastObject;
    
    if (!galleryMO) {
        galleryMO = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
        galleryMO.galleryID = idString;
    }
    
    return galleryMO;
}

+(void)cleanUpDataBaseAtContext:(NSManagedObjectContext *)context {
    
    [GAArtItemMO cleanUpDataBaseAtContext:context];
    
    NSError *error = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.includesPropertyValues = NO;
    
    NSArray *resultObject = [context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@" error %@",error.localizedDescription);
    }
    
    for (id managedObject in resultObject) {
        [context deleteObject:managedObject];
    }
    
    [context save:&error];
    
    if (error) {
        NSLog(@" error %@",error.localizedDescription);
    }

}

+(NSFetchedResultsController *)fetchedResultsControllerOfAllGalleriesAtContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"galleryID" ascending:YES];
    request.sortDescriptors = @[descriptor];
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    return frc;

}

-(CLLocationCoordinate2D)locationCoordinate2D {
    CGFloat lon = self.lon.doubleValue;
    CGFloat lat = self.lat.doubleValue;
    
    return CLLocationCoordinate2DMake(lat, lon);

}
@end
