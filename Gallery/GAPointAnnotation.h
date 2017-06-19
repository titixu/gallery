//
//  GAPointAnnotation.h
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import <MapKit/MapKit.h>
@class GAGalleryMO;

@interface GAPointAnnotation : MKPointAnnotation
@property (nonatomic, strong) NSString *galleryID;

@end
