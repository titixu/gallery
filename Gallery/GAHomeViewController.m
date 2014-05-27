//
//  GAHomeViewController.m
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GAHomeViewController.h"
#import <MapKit/MapKit.h>

@interface GAHomeViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation GAHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}



#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

@end
