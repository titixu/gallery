//
//  GAGalleryListViewController.h
//  Gallery
//
//  Created by sam xu on 27/05/2014.
//  Copyright (c) 2014 SAM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GAGalleriesTableViewDataSource;

@interface GAGalleryListViewController : UIViewController <UITabBarDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet GAGalleriesTableViewDataSource *dataSource;

@end
