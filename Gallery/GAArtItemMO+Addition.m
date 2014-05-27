//
//  GAArtItemMO+Addition.m
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GAArtItemMO+Addition.h"
#import "GAGalleryMO+Addition.h"

#define entityName @"ArtItem"

@implementation GAArtItemMO (Addition)

+(void)storeWithName:(NSString *)name forGallerMO:(GAGalleryMO *)galleryMO {
    
    NSManagedObjectContext *context = galleryMO.managedObjectContext;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    
    request.predicate = predicate;
    
    NSError *error = nil;
    
    NSArray *resultArray = [context executeFetchRequest:request error:&error];
    
    GAArtItemMO *artItemMo = resultArray.lastObject;
    
    if (!artItemMo) {
        artItemMo = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
        artItemMo.name = name;
    }
}


+(void)cleanUpDataBaseAtContext:(NSManagedObjectContext *)context {
    
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

+(NSFetchedResultsController *)fetchedResultsControllerOfArtItemsFor:(GAGalleryMO *)gallery {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[descriptor];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"belongToGallery = %@", gallery];
    
    request.predicate = predicate;
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:gallery.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    return frc;

}

-(UIImage *)ratingImage {
    NSString *imageName =[ NSString stringWithFormat:@"%i_Stars", self.rate.integerValue];
    UIImage *image =[UIImage imageNamed:imageName];
    return image;
}

-(void)increaseRate {
    NSInteger rate = self.rate.integerValue;
    rate ++;
    if (rate > 5) {
        rate = 0;
    }
    self.rate = [NSNumber numberWithInteger:rate];
}
@end
