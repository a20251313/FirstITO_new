//
//  DataFromService.h
//  TXFishing
//
//  Created by chen mj on 12-10-24.
//  Copyright (c) 2012年 chen mj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReceiveDataFromService : NSObject
{
    NSString *_appVersion;
    
    NSString *_appDeviceToken;

}

@property (nonatomic, copy) NSString *appVersion;

@property (nonatomic, copy) NSString *appDeviceToken;



/* 检查产品更新,同步数据接口*/
- (NSString *)CheckEditProductDataToServer:(NSDictionary *)dictData;



@end
