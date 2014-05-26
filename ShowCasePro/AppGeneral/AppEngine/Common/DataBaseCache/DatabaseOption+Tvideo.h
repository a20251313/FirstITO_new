//
//  DatabaseOption+Tvideo.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-13.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption.h"
#import "Tvideo.h"

@interface DatabaseOption (Tvideo)

- (NSMutableArray *)selectVideoByBrandID:(NSString *)brandid andSuiteID:(NSString *)suiteid; // 根据品牌id和系列id查询视频
- (Tvideo *)selectVideoByID:(NSString *)videoid;
- (NSMutableArray *)selectVideosByIDs:(NSString *)ids;

@end
