//
//  GAArtItemMO.h
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GAGalleryMO;

@interface GAArtItemMO : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) GAGalleryMO *belongToGallery;

@end
