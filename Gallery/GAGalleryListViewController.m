//
//  GAGalleryListViewController.m
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GAGalleryListViewController.h"
#import "GAGalleriesTableViewDataSource.h"
#import "GAGalleryMO+Addition.h"
#import "GACoreDataWriterManager.h"

@interface GAGalleryListViewController ()
@end

@implementation GAGalleryListViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource.frc = [GAGalleryMO fetchedResultsControllerOfAllGalleriesAtContext:[GACoreDataWriterManager sharedManager].managedObjectContext];
    [self.dataSource fetchNewData];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
