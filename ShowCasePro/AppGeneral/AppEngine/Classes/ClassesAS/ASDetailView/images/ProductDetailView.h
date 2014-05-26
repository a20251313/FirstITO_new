//
//  ProductDetailView.h
//  ProductDetailView
//
//  Created by CY-003 on 13-11-13.
//  Copyright (c) 2013年 CY-003. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductIntroView.h"
#import "Tproduct.h"
#import "BaseViewController.h"

@class Tproduct;

@interface ProductDetailView : BaseViewController<UIGestureRecognizerDelegate>

@property(nonatomic,strong) Tproduct *tProduct;

@property(nonatomic,strong) NSString *productid;

//搜索界面 或 产品选择界面 所有产品结果
//@property (nonatomic , strong) NSArray *allProductData;

- (void) reloadData;

@end
