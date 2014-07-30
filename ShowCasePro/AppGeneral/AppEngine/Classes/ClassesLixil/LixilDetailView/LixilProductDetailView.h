//
//  LixilProductDetailView.h
//  LixilProductDetailView
//
//  Created by CY-003 on 13-11-13.
//  Copyright (c) 2013年 CY-003. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InaxProductIntroView.h"
#import "Tproduct.h"
#import "LixilBaseViewController.h"


@class Tproduct;

@interface LixilProductDetailView : LixilBaseViewController<UIGestureRecognizerDelegate>

@property(nonatomic,strong) Tproduct *tProduct;

@property(nonatomic,strong) NSString *productid;

@property(nonatomic)BOOL    isShowCer;

@property(nonatomic)BOOL    isLixiWoodlen;

- (void) reloadData;

@end
