//
//  NSDictionary+FetchObjectWithType.h
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FetchObjectWithType)
-(NSString *)stringWithKey:(NSString *)key;
-(NSArray *)arrayWithKey:(NSString *)key;
@end
