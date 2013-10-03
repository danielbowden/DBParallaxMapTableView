//
//  DBParalaxMapTableView.m
//  DBParallaxMapTableView
//
//  Created by Daniel Bowden on 12/09/13.
//  Copyright (c) 2013 Daniel Bowden. All rights reserved.
//

#import "DBParalaxMapTableView.h"

#import <QuartzCore/QuartzCore.h>

#define kMapHeaderOffsetY -150.0
#define kMapHeaderHeight 250.0

@implementation DBParalaxMapTableView

@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView = [[DBParalaxTableView alloc] initWithFrame:frame];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.layer.shadowOffset = CGSizeMake(0, 1.0);
        self.tableView.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.tableView.bounces = YES;
        self.tableView.bouncesZoom = YES;
        self.tableView.alwaysBounceVertical = YES;
        self.tableView.delegate = self;
        [self addSubview:self.tableView];
        
        UIView *tableHeader = [[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, frame.size.width, kMapHeaderHeight)];
        tableHeader.backgroundColor = [UIColor clearColor];
        self.tableView.tableHeaderView = tableHeader;
        
        self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, kMapHeaderOffsetY, CGRectGetWidth(frame), CGRectGetHeight(frame) + ABS(kMapHeaderOffsetY))];
        self.mapView.delegate = self;
        [self insertSubview:self.mapView belowSubview:self.tableView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<DBParalaxTableViewDelegate>)delegate dataSource:(id<DBParalaxTableViewDataSource>)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView = [[DBParalaxTableView alloc] initWithFrame:frame];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.layer.shadowOffset = CGSizeMake(0, 1.0);
        self.tableView.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.tableView.bounces = YES;
        self.tableView.bouncesZoom = YES;
        self.tableView.alwaysBounceVertical = YES;
        self.tableView.delegate = self;
        [self addSubview:self.tableView];
        
        UIView *tableHeader = [[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, frame.size.width, kMapHeaderHeight)];
        tableHeader.backgroundColor = [UIColor clearColor];
        self.tableView.tableHeaderView = tableHeader;
        
        self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, kMapHeaderOffsetY, CGRectGetWidth(frame), CGRectGetHeight(frame) + ABS(kMapHeaderOffsetY))];
        self.mapView.delegate = self;
        [self insertSubview:self.mapView belowSubview:self.tableView];
    }
    return self;

}

- (id<UITableViewDelegate>)delegate
{
    return self.tableView.delegate;
}

- (void)setDelegate:(id<DBParalaxTableViewDelegate>)dlg
{
    if (_delegate != dlg)
    {
        _delegate = dlg;
    }
    
    [self.tableView setDelegate:self];
}

- (id<UITableViewDataSource>)dataSource
{
    return self.tableView.dataSource;
}

- (void)setDataSource:(id<DBParalaxTableViewDataSource>)ds
{
    if (_dataSource != ds)
    {
        _dataSource = ds;
    }
    
    [self.tableView setDataSource:self];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollOffset = scrollView.contentOffset.y;
    CGRect headerFrame = self.mapView.frame;
    
    if (scrollOffset < 0)
    {
        headerFrame.origin.y = MIN(kMapHeaderOffsetY - ((scrollOffset / 3)), 0);
        
    }
    else //scrolling up
    {
        headerFrame.origin.y = kMapHeaderOffsetY - scrollOffset;
    }

    self.mapView.frame = headerFrame;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)])
    {
        return [_dataSource numberOfSectionsInTableView:tableView];
    }
    else
    {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)])
    {
        return [_dataSource tableView:tableView numberOfRowsInSection:section];
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)])
    {
        return [_dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else
    {
        return nil;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)])
    {
        [_delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
    {
        return [_delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    else
    {
        return 44.0;
    }
}

- (void)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)])
    {
        [_delegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if ([_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
     {
         [_delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
     }
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)map didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (userLocation && CLLocationCoordinate2DIsValid(userLocation.coordinate))
    {
        [map setRegion:[map regionThatFits:MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500)] animated:YES];
    }
}

@end


//Pass header touches through to the mapView to allow user to control/zoom it
@implementation DBParalaxTableView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self.tableHeaderView) {
        return nil;
    }
    return view;
}

@end
