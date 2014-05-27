//
//  GAAppDelegate.m
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GAAppDelegate.h"
#import "GACoreDataWriterManager.h"

@implementation GAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

-(void)applicationWillResignActive:(UIApplication *)application {
    [[GACoreDataWriterManager sharedManager] saveContext];
}

-(void)applicationWillTerminate:(UIApplication *)application {
    [[GACoreDataWriterManager sharedManager] saveContext];
}
@end
