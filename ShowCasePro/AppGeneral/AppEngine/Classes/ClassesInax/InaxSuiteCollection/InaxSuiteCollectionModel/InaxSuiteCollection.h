//
//  InaxSuiteCollection.h
//  ShowCasePro
//
//  Created by Mac on 14-3-23.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InaxSuiteCollection : NSObject

@property(nonatomic , strong) NSString *InaxSuiteCollectionID;      //id
@property(nonatomic , strong) NSString *name;                       //简单描述
@property(nonatomic , strong) NSString *suite_id;                   //套间
@property(nonatomic , strong) NSString *type_id;                    //类别
@property(nonatomic , strong) NSString *des_image;                  //描述图片
@property(nonatomic , strong) NSString *detail_image;               //详细描述图片
@property(nonatomic , strong) NSString *bg_image;                   //背景图片
@property(nonatomic , strong) NSString *update_time;                //更新时间
@property(nonatomic , strong) NSString *orderby;                    //排序
@property(nonatomic , strong) NSString *brand_id;

@end
