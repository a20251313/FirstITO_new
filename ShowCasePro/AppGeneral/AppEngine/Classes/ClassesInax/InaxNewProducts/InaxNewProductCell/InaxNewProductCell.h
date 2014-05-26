//
//  InaxNewProductCell.h
//  ShowCasePro
//
//  Created by Mac on 14-3-22.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InaxNewProduct.h"

@interface InaxNewProductCell : UITableViewCell

@property (nonatomic , strong) InaxNewProduct *inaxNewProduct;

- (void) showWithProduct:(InaxNewProduct *)inaxNewProduct;

@end
