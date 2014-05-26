//
//  InaxLeadingTechViewController.h
//  ShowCasePro
//
//  Created by Mac on 14-3-18.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxBaseViewController.h"

@interface InaxLeadingTechViewController : InaxBaseViewController<UICollectionViewDataSource, UICollectionViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong)NSMutableArray *externalArray;
@end
