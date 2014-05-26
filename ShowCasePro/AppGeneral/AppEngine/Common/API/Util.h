//
//
//  AppDelegate.h
//  ShouGouAPP
//
//  Created by yczx on 13-3-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface Util : NSObject

/*初始化UtilFunction*/
+ (id)shareInstance;


/*将NSData数据转化成UIImage对象*/
- (UIImage *)changeNSDateToImage:(NSData *)srcData;

/*将字符串转化成MD5码*/
- (NSString *)stringToMD5:(NSString *)src;

/*判断数据是否为NSNull*/
- (NSString *)checkNullString:(NSString *)src;

/*判断数据是否为NSNull 转化为Int*/
- (NSString *)checkNullASIntToZero:(NSString *)src;

/*将URL指定的图片下载到本地*/
- (UIImage *)imageFromURL:(NSString *)imgURl;


/*向右边翻转*/
- (CATransition *)transitionFromLeft;

/*向左边翻转*/
- (CATransition *)transitionFromRight;

@end
