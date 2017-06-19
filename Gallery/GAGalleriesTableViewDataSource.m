//
//  GAGalleriesTableViewDataSource.m
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GAGalleriesTableViewDataSource.h"
#import "GAGalleryMO+Addition.h"

@implementation GAGalleriesTableViewDataSource

-(void)fetchNewData {
    NSError *error = nil;
    [self.frc performFetch:&error];
    if (error) {
        NSLog(@"error %@", error);
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.frc.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[section];
    return [sectionInfo numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GAGalleryTableViewCellIdentifier" forIndexPath:indexPath];
    
    GAGalleryMO *galleryMo = [self.frc objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Gallery ID %@", galleryMo.galleryID];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Address: %@", galleryMo.streetName];
    
    return cell;
    
}
@end
