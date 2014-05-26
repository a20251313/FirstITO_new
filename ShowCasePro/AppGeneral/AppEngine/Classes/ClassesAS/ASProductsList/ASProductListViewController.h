//
//  ASProductListViewController.h
//  ShowCasePro
//
//  Created by lvpw on 14-3-14.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, ASProductListType) {
    SearchType = 0,
    CategoryType,
    SuiteType,
    MtoType
};

@interface ASProductListViewController : BaseViewController {
    @public
    ASProductListType _asProductListType; // 进入方式
}

@property (nonatomic, strong) NSString *value; // 对应的值
@property (nonatomic, strong) NSString *productTypeid; // 系列进入时设置type大类
@property (nonatomic, strong) NSArray *originProductsArray; // 初始产品数组
@property (nonatomic, strong) UIColor *color;

@end
