//
//  InaxNewProductListViewController.h
//  ShowCasePro
//
//  Created by CY-003 on 14-5-6.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxBaseViewController.h"
#import "InaxNewProduct.h"

@interface InaxNewProductListViewController : InaxBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic , strong) NSArray *productsArray;
@end
