//
//  GAArtItemCollectionCell.h
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GAArtItemCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *artNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *artItemDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ratingImageView;

@end
