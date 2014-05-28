//
//  GAHomeViewController.m
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GAHomeViewController.h"
#import <MapKit/MapKit.h>
#import "GACoreDataWriterManager.h"
#import "GAGalleryMO+Addition.h"
#import "GAPointAnnotation.h"
#import "GAArtItemsDisplayViewController.h"

@interface GAHomeViewController () <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSFetchedResultsController *frc;
@end

@implementation GAHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.frc = [GAGalleryMO fetchedResultsControllerOfAllGalleriesAtContext:[GACoreDataWriterManager sharedManager].managedObjectContext];
    self.frc.delegate = self;
    
    [self.frc performFetch:NULL];
    
    //default go to first gallery
    if (self.frc.sections.count) {
        id <NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[0];
        if ([sectionInfo objects].count) {
            GAGalleryMO *galleryMo = [sectionInfo objects][0];
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([galleryMo locationCoordinate2D], 10000, 10000);
            [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        }
        
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadAnnotations];
}

#pragma mark - Private methods
-(void)loadAnnotations {
    if (self.frc.sections.count) {
        id <NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[0];
        for (GAGalleryMO *galleryMO in [sectionInfo objects]) {
            
            GAPointAnnotation *point = [[GAPointAnnotation alloc] init];
            point.coordinate = [galleryMO locationCoordinate2D];
            point.title = [NSString stringWithFormat:@"Gallery ID %@", galleryMO.galleryID];
            point.subtitle = [NSString stringWithFormat:@"Number of art items %i", galleryMO.hasArtItems.count];
            
            point.galleryID = galleryMO.galleryID;
            
            [self.mapView addAnnotation:point];
            
        }
    }

}

-(void)pushArtItemViewControllerWithGalleryID:(NSString *)galleryID {

    GAArtItemsDisplayViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GAArtItemsDisplayViewController"];
    vc.galleryID = galleryID;

    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - MKMapViewDelegate methods
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    GAPointAnnotation *annotation = view.annotation;
    if ([annotation isKindOfClass:[GAPointAnnotation class]]) {
        NSString *galleryID = annotation.galleryID;
        [self pushArtItemViewControllerWithGalleryID:galleryID];
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[GAPointAnnotation class]]) {
        static NSString *annotationViewIdentifier = @"GAAnnotationViewIdentifier";
        MKPinAnnotationView* annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewIdentifier];
        if (!annotationView) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:annotationViewIdentifier];
            annotationView.image = [UIImage imageNamed:@"defaultIcon"];
            annotationView.animatesDrop = YES;
            annotationView.canShowCallout = YES;
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            annotationView.rightCalloutAccessoryView = rightButton;
        }
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - FRC delegate methods
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self loadAnnotations];
}


@end
