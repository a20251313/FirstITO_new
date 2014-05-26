//
//  CusMAPinAnnotationView.h
//  MapDemo
//
//  Created by CY-004 on 13-11-13.
//  Copyright (c) 2013年 CY. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "Store.h"
#import "Twarehouse.h"

// 自定义MAPinAnnotationView中的calloutView
@interface CusMAPinAnnotationView : MAPinAnnotationView

@property (nonatomic, strong) UIView *calloutView;
@property (nonatomic, strong) Store *store;
@property (nonatomic, strong) Twarehouse *warehouse;
@property (nonatomic, weak) MAMapView *mapView;

@end
