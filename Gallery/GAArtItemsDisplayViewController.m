//
//  GAArtItemsDisplayViewController.m
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GAArtItemsDisplayViewController.h"
#import "GAArtItemCollectionCell.h"

#import "GAArtItemMO+Addition.h"
#import "GAGalleryMO+Addition.h"
#import "GACoreDataWriterManager.h"

@interface GAArtItemsDisplayViewController ()
@property (nonatomic,strong) NSFetchedResultsController *frc;
@end

@implementation GAArtItemsDisplayViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSManagedObjectContext *content = [GACoreDataWriterManager sharedManager].managedObjectContext;
    GAGalleryMO * galleryMO = [GAGalleryMO galleryMOWithID:self.galleryID atContext:content];
    self.frc = [GAArtItemMO fetchedResultsControllerOfArtItemsFor:galleryMO];
    [self.frc performFetch:NULL];
    [self.collectionView reloadData];
}

#pragma mark - collection view data source methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.frc.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[section];
    return [sectionInfo numberOfObjects];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GAArtItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GAArtItemCollectionCellIdentifier" forIndexPath:indexPath];
    
    GAArtItemMO *artItem = [self.frc objectAtIndexPath:indexPath];
    cell.artNameLabel.text = artItem.name;
    cell.ratingImageView.image = [artItem ratingImage];
    return cell;
}

#pragma mark - collection view delegate methods

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GAArtItemMO *artItemMO = [self.frc objectAtIndexPath:indexPath];
    [artItemMO increaseRate];
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}
@end
