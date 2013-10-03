//
//  DBParalaxMapTableView.h
//  DBParallaxMapTableView
//
//  Created by Daniel Bowden on 12/09/13.
//  Copyright (c) 2013 Daniel Bowden. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>

@interface DBParalaxTableView : UITableView
@end

@protocol DBParalaxTableViewDelegate <UITableViewDelegate>
@end

@protocol DBParalaxTableViewDataSource <UITableViewDataSource>
@end

@interface DBParalaxMapTableView : UIView <MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, weak) id<UITableViewDelegate, DBParalaxTableViewDelegate> delegate;
@property (nonatomic, weak) id<UITableViewDataSource, DBParalaxTableViewDataSource> dataSource;

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) DBParalaxTableView *tableView;

- (id)initWithFrame:(CGRect)frame delegate:(id<DBParalaxTableViewDelegate>)delegate dataSource:(id<DBParalaxTableViewDataSource>)dataSource;

@end
