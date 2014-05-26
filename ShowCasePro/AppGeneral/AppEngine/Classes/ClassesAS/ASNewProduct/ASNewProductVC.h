//
//  ASNewProductVC.h
//  ShowCasePro
//
//  Created by yczx on 14-2-26.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "BaseViewController.h"
#import "BrandSpaceButton.h"


@interface ASNewProductVC : BaseViewController


// 视图中间位置 新品速递 标题
@property (strong, nonatomic) IBOutlet UIImageView *asnewProTitleImage;

// 显示内容的滚动视图
@property (strong, nonatomic) IBOutlet UIScrollView *asnewProScrollView;

// PageControl
@property (strong, nonatomic) IBOutlet UIPageControl *aspageControl;

// 存放滚动视图内容数据集合
@property (nonatomic, strong) NSMutableArray *itemList;

// 背景版视图
@property (strong, nonatomic) IBOutlet UIView *itemBgView;

// 内容介绍面板
@property (strong, nonatomic) IBOutlet UIImageView *itemContentView;

// 本地存放数据
@property(nonatomic,strong) NSMutableDictionary *productLocalDict;

// 新品介绍内容视图
@property (weak, nonatomic) IBOutlet UIScrollView *asnewProdDescView;


@property(nonatomic,strong) BrandSpaceButton *currSelBtn;

@property(nonatomic,assign) CGPoint befortMovePoint;

@end
