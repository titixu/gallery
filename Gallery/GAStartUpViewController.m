//
//  GAStartUpViewController.m
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GAStartUpViewController.h"
#import "GAGalleryDataFetchModel.h"
#import "GACoreDataWriterManager.h"

@interface GAStartUpViewController ()
@property (nonatomic, strong) GAGalleryDataFetchModel *dataFetchModel;

@end

@implementation GAStartUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadGalleryData];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadHomeViewController];
    });
}

-(void)loadGalleryData {
    [self.dataFetchModel fetchGallerysDataWithFinishHandler:^(id object) {
        if ([object isKindOfClass:[NSError class]]) {
            [self handleError:object];
        } else {
            [self handleResult:object];
        }
    }];
    
}

-(void)handleError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"Internet Error!" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}

-(void)handleResult:(NSDictionary *)dictionary {
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        [[GACoreDataWriterManager sharedManager] writeToCoreDataWithDictionary:dictionary];
    } else {
        [self handleError:nil];
    }
}

#pragma mark - Getter methods
-(GAGalleryDataFetchModel *)dataFetchModel {
    if(!_dataFetchModel) {
        _dataFetchModel = [[GAGalleryDataFetchModel alloc] init];
    }
    return _dataFetchModel;
}

#pragma mark - Private methods
-(void)loadHomeViewController {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AGMapNavigationController"];
    self.view.window.rootViewController = vc;
}

@end
