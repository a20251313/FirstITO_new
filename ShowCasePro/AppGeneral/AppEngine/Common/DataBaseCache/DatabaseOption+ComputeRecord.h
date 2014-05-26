//
//  DatabaseOption+ComputeRecord.h
//  ShowCasePro
//
//  Created by Mac on 14-3-17.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption.h"

@interface DatabaseOption (ComputeRecord)

//添加一条新数据
- (void) addNewRecord:(NSString *)newRecord;
//清空数据库
- (void) cleanAllRecord;
//返回所有数据
- (NSMutableArray *) allRecord;

@end
