//
//  Room3D.h
//  ShowCasePro
//
//  Created by dd on 14-4-29.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Room3D : NSObject

@property (nonatomic , strong) NSString *room_id;           //id
@property (nonatomic , strong) NSString *suite_id;          //对应的套间id
@property (nonatomic , strong) NSString *bgimage;           //背景图
@property (nonatomic , strong) NSString *update_time;       //不用管
@property (nonatomic , strong) NSString *status;            //1正常  0不显示
@property (nonatomic , strong) NSString *param1;            //以下为备用
@property (nonatomic , strong) NSString *param2;
@property (nonatomic , strong) NSString *param3;
@property (nonatomic , strong) NSString *param4;

@end
