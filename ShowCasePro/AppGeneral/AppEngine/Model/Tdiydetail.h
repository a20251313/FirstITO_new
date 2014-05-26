//
//  Tdiydetail.h
//  ShowCasePro
//
//  Created by lvpw on 13-11-28.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tproduct.h"
#import "ObjectBase.h"

@interface Tdiydetail : ObjectBase

@property (nonatomic, strong) NSString *tdiydetailid;
@property (nonatomic, strong) NSString *floderid;
@property (nonatomic, strong) NSString *productid;
@property (nonatomic, strong) Tproduct *product;
@property (nonatomic, strong) NSString *productimage;
@property (nonatomic, strong) NSString *productname;
@property (nonatomic, strong) NSString *productcode;
@property (nonatomic, strong) NSString *update_time;
@property (nonatomic, strong) NSString *version;

@end
