//
//  NSDictionary+FetchObjectWithType.m
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "NSDictionary+FetchObjectWithType.h"

@implementation NSDictionary (FetchObjectWithType)

-(NSString *)stringWithKey:(NSString *)key {
    
    id resultObject = [self objectForKey:key];
    
    if ([resultObject isKindOfClass:[NSString class]]) {
        return resultObject;
    }
    
    if ([resultObject isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", resultObject];
    }
    
    return nil;
}

-(NSArray *)arrayWithKey:(NSString *)key {
    id resultObject = [self objectForKey:key];
    
    if ([resultObject isKindOfClass:[NSArray class]]) {
        return resultObject;
    }
    
    if ([resultObject isKindOfClass:[NSDictionary class]]) {
        return @[resultObject];
        
    }
    return nil;

}
@end
