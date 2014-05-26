//
//  ProductIntroView.h
//  ProductDetailView
//
//  Created by CY-003 on 13-11-12.
//  Copyright (c) 2013年 CY-003. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tproduct.h"

@class Product;
@class ProductIntroView;
@protocol ProductIntroViewDelegate <NSObject>

- (void)didSelectProductIntroView:(ProductIntroView *)productIntroView;

@end

@interface ProductIntroView : UIView
{
    UIImageView *productImageView;
    
    UIView *textView;
    
    UILabel *nameLable;
    UILabel *modelLable;
    
    UIButton *button;
}

@property (nonatomic ,strong) NSString *productid;
@property (nonatomic ,strong) Tproduct *tProduct;
@property (nonatomic, weak) id<ProductIntroViewDelegate> delegate;

- (void) reloadData;

@end
