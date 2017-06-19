//
//  GAArtItemMO+Addition.h
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GAArtItemMO.h"
@class GAGalleryMO;

@interface GAArtItemMO (Addition)
+(void)cleanUpDataBaseAtContext:(NSManagedObjectContext *)context;

+(void)storeWithName:(NSString *)name forGallerMO:(GAGalleryMO *)galleryMO;

+(NSFetchedResultsController *)fetchedResultsControllerOfArtItemsFor:(GAGalleryMO *)gallery;

-(UIImage *)ratingImage;

-(void)increaseRate;
@end
