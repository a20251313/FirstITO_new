//
//  Type3D.h
//  ShowCasePro
//
//  Created by dd on 14-4-29.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Type3D : NSObject

@property (nonatomic , strong) NSString *type_id;           //id
@property (nonatomic , strong) NSString *room_id;           //所属房间id
@property (nonatomic , strong) NSString *product_pos;       //产品图片中心位置  格式为  250,250
@property (nonatomic , strong) NSString *button_pos;        //按钮中心位置      格式为  250,250
@property (nonatomic , strong) NSString *type_bg_image;     //下方collection view的背景图片
@property (nonatomic , strong) NSString *product_id;        //可以替换的3d产品  格式为  1,2,3,4,5  在套间里默认显示第一个
@property (nonatomic , strong) NSString *update_time;       //不用管
@property (nonatomic , strong) NSString *status;            //1正常  0不显示
@property (nonatomic , strong) NSString *param1;            //以下为备用
@property (nonatomic , strong) NSString *param2;
@property (nonatomic , strong) NSString *param3;
@property (nonatomic , strong) NSString *param4;

@end
