//
//  FormatData.h
//  TXFishing
//  将从服务器上面请求下来的数据转化成应用内部的数据对象
//
//  AppDelegate.h
//  ShouGouAPP
//
//  Created by yczx on 13-3-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FormatData : NSObject

+ (id)shareInstance;

/*请求下来的数据完成封装*/
- (NSMutableArray *)formatDictToQuestionData:(NSArray *)dictArray;

@end
