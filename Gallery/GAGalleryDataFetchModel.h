//
//  GAGalleryDataFetchModel.h
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GAGalleryDataFetchModel : NSObject
-(void)fetchGallerysDataWithFinishHandler:(void(^)(id object))finishHandler;
-(void)cancel;
@end
