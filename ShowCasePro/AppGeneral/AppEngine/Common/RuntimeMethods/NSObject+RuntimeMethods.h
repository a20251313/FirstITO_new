//
//  NSObject+RuntimeMethods.h
//
//  Created by Yang Xudong.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RuntimeMethods)

//获取当前对象的属性列表
- (NSArray *)propertyList;

//获取当前对象的非空属性列表以及属性值
- (NSDictionary *)propertyValues;

//获取当前对象的所有属性列表以及属性值
- (NSDictionary *)allPropertyValues;

//对当前对象进行赋值
- (void)voluationWithData:(id)data;



//获取当前对象的方法列表
- (NSArray *)methodList;

//获取当前对象的实例变量列表
- (NSArray *)ivarList;

//获取对象值与变量名的string
-(NSString *)getdescriptionOfobject:(id)object;
@end
