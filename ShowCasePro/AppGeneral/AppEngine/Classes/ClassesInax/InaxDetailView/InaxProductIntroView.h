//
//  InaxProductIntroView.h
//  InaxProductIntroView
//
//  Created by CY-003 on 13-11-12.
//  Copyright (c) 2013年 CY-003. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tproduct.h"

@class Product;
@class InaxProductIntroView;
@protocol InaxProductIntroViewDelegate <NSObject>

- (void)didSelectProductIntroView:(InaxProductIntroView *)productIntroView;

@end

@interface InaxProductIntroView : UIView
{
    UIImageView *productImageView;
    
    UIView *textView;
    
    UILabel *nameLable;
    UILabel *modelLable;
    
    UIButton *button;
}

@property (nonatomic ,strong) NSString *productid;
@property (nonatomic ,strong) Tproduct *tProduct;
@property (nonatomic, weak) id<InaxProductIntroViewDelegate> delegate;


- (UIImage*)getProductImage;
- (void) reloadData;

@end
