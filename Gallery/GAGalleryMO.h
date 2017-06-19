//
//  GAGalleryMO.h
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GAArtItemMO;

@interface GAGalleryMO : NSManagedObject

@property (nonatomic, retain) NSString * streetName;
@property (nonatomic, retain) NSString * galleryID;
@property (nonatomic, retain) NSString * postcode;
@property (nonatomic, retain) NSString * lon;
@property (nonatomic, retain) NSString * lat;
@property (nonatomic, retain) NSString * suburb;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSSet *hasArtItems;
@end

@interface GAGalleryMO (CoreDataGeneratedAccessors)

- (void)addHasArtItemsObject:(GAArtItemMO *)value;
- (void)removeHasArtItemsObject:(GAArtItemMO *)value;
- (void)addHasArtItems:(NSSet *)values;
- (void)removeHasArtItems:(NSSet *)values;

@end
