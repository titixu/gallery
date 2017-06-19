//
//  GAGalleriesTableViewDataSource.h
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GAGalleriesTableViewDataSource : NSObject <UITableViewDataSource>
@property (nonatomic, strong) NSFetchedResultsController *frc;

-(void)fetchNewData;
@end
