//
//  TproductPropertyValue.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-10.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectBase.h"

@interface TproductPropertyValue : ObjectBase

@property (strong, nonatomic) NSString *tproductPropertyValueid;
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSString *propertyid;
@property (strong, nonatomic) NSString *update_time;
@property (strong, nonatomic) NSString *version;

@end
