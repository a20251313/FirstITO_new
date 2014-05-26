//
//  InaxProductDetailView.h
//  InaxProductDetailView
//
//  Created by CY-003 on 13-11-13.
//  Copyright (c) 2013年 CY-003. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InaxProductIntroView.h"
#import "Tproduct.h"
#import "InaxBaseViewController.h"


@class Tproduct;

@interface InaxProductDetailView : InaxBaseViewController<UIGestureRecognizerDelegate>

@property(nonatomic,strong) Tproduct *tProduct;

@property(nonatomic,strong) NSString *productid;

- (void) reloadData;

@end
