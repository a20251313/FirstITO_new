//
//  TproductPropertyValue.m
//  ShowCasePro
//
//  Created by lvpw on 13-12-10.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "TproductPropertyValue.h"

@implementation TproductPropertyValue

- (void)setTproductPropertyValueid:(NSString *)tproductPropertyValueid
{
//    self.baseid = tproductPropertyValueid;
    _tproductPropertyValueid = tproductPropertyValueid;
}

- (void)setValue:(NSString *)value
{
    self.baseid = value;
    self.name = value;
    _value = value;
}

@end
