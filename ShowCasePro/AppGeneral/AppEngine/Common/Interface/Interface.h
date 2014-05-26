//
//  Interface.h

//  画面调用数据的接口
//
//  AppDelegate.h
//  ShouGouAPP
//
//  Created by yczx on 13-3-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Interface : NSObject

/*创建一个实例*/
+ (id)shareInstance;

/*
 @param userId 获取活动一览界面
 */

/* 检查产品更新,同步数据接口*/
-(NSDictionary *)GetEditedProductDataToServerInterface:(NSDictionary *)dictData;



@end
