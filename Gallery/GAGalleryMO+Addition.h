//
//  GAGalleryMO+Addition.h
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GAGalleryMO.h"
#import <MapKit/MapKit.h>

@interface GAGalleryMO (Addition)

+(void)storeGalleryWithDictionary:(NSDictionary *)dataDictionary atContext:(NSManagedObjectContext *)context;

+(GAGalleryMO *)galleryMOWithID:(NSString *)idString atContext:(NSManagedObjectContext *)context;

+(void)cleanUpDataBaseAtContext:(NSManagedObjectContext *)context;

+(NSFetchedResultsController *)fetchedResultsControllerOfAllGalleriesAtContext:(NSManagedObjectContext *)context;

-(CLLocationCoordinate2D)locationCoordinate2D;
@end

