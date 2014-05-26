//
//  InaxNewProduct.h
//  ShowCasePro
//
//  Created by Mac on 14-3-22.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InaxNewProduct : NSObject

@property(nonatomic , strong) NSString *InaxNewProductID;   //id
@property(nonatomic , strong) NSString *name;               //简单描述
@property(nonatomic , strong) NSString *suiteid;            //套间
@property(nonatomic , strong) NSString *type_id;            //类别
@property(nonatomic , strong) NSString *subtypeid;          //子类别
@property(nonatomic , strong) NSString *image;              //图片
@property(nonatomic , strong) NSString *update_time;        //更新时间
@property(nonatomic , strong) NSString *orderby;            //排序
@property(nonatomic , strong) NSString *section;            //列数

@end
