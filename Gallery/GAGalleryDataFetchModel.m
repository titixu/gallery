//
//  GAGalleryDataFetchModel.m
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GAGalleryDataFetchModel.h"

typedef void(^FinishHandler)(id object);

@interface GAGalleryDataFetchModel ()
@property (nonatomic, copy) FinishHandler finishHandler;
@end

@implementation GAGalleryDataFetchModel

-(void)fetchGallerysDataWithFinishHandler:(void(^)(id object))finishHandler {
    self.finishHandler = finishHandler;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"data" withExtension:@"json"];
    
    dispatch_async(dispatch_queue_create("GA.galleryDataFetchQueue", NULL), ^{
        
        NSData *data = nil;
        NSError *error = nil;
        
        data = [NSData dataWithContentsOfURL:url
                                     options:NSDataReadingMapped
                                       error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!data.length || error) {
                [self handleError:error withFinishHandler:finishHandler];
            } else {
                [self handleResultData:data withFinishHandler:self.finishHandler];
            }
        });
    });
}

-(void)handleError:(NSError *)error withFinishHandler:(void(^)(id object))finishHandler {
    if (finishHandler) {
        finishHandler(error);
    }
}

-(void)handleResultData:(NSData *)data withFinishHandler:(void(^)(id object)) finishHandler {
    
    NSError *error = nil;
    
    id resultObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (!resultObject || error) {
        [self handleError:error withFinishHandler:finishHandler];
    } else {
        if (finishHandler) {
            finishHandler(resultObject);
        }
    }

}

-(void)cancel {
    self.finishHandler = nil;
}
@end
