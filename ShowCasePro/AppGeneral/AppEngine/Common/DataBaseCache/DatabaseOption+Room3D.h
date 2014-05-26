//
//  DatabaseOption+Room3D.h
//  ShowCasePro
//
//  Created by dd on 14-4-29.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption.h"
#import "Room3D.h"
#import "Type3D.h"
#import "Product3D.h"

@interface DatabaseOption (Room3D)

//根据套间id获取对应的3d房间
- (Room3D *) roomWithSuiteID:(NSString *)suiteID;

//根据3d房间id获取此房间内所有可展示的类别
- (NSArray *) typesWithRoomID:(NSString *)roomID;

//根据3d产品id获取该产品详情
- (Product3D *) product3DWithProductID:(NSString *)productID;

//根据类别获取此类别所有产品信息
- (NSArray *) productsWithTypeID:(NSString *)typeID;

@end
