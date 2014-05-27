//
//  GAArtItemsDisplayViewController.h
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GAArtItemsDisplayViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, copy) NSString *galleryID;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end
