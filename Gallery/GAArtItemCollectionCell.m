//
//  GAArtItemCollectionCell.m
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import "GAArtItemCollectionCell.h"

@implementation GAArtItemCollectionCell
-(void)awakeFromNib {
    [super awakeFromNib];
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor = [UIColor blueColor];
    self.selectedBackgroundView = backgroundView;
}
@end
