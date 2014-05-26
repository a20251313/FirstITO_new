//
//  Interface.m
//
//  AppDelegate.h
//  ShouGouAPP
//
//  Created by yczx on 13-3-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "Interface.h"
#import "ReceiveDataFromService.h"
#import "FormatData.h"
#import "GetJson.h"
#import "Util.h"
#import "AppConfig.h"

enum
{
    RESPONSE_SUCCESS= 0,    //请求数据成功
    RESPONSE_ERROR = 1,     //请求错误
    RESPONSE_EMPTY = 2,     //请求的数据为空
    
}RESPONSE;

@interface Interface ()

/*判断用户请求到的信息是否是正确的或者有没有消息*/
- (NSInteger)checkResponse:(NSDictionary *)responseDict;


@end


@implementation Interface

+ (id)shareInstance
{
    
    static Interface *gInterface = nil;
    // 2.声明一个静态变量dispatch_once_t ,它确保初始化器代码只执行一次
    static dispatch_once_t oncePredicate;
    // 3.使用Grand Central Dispatch(GCD)执行初始化LibraryAPI变量的block.这  正是单例模式的关键：一旦类已经被初始化，初始化器永远不会再被调用。
    dispatch_once(&oncePredicate, ^{
        gInterface = [[Interface alloc] init];
    });
    return gInterface;
    
}


/*判断用户请求到的信息是否是正确的或者有没有消息*/
- (NSInteger)checkResponse:(NSDictionary *)responseDict
{
    if ([responseDict objectForKey:CHECK_RESULT]) {
        if ([responseDict objectForKey:RETURN_USER_DATA]) {
            return RESPONSE_SUCCESS;
        }else{
            return RESPONSE_EMPTY;
        }
        
    }else{
        return RESPONSE_ERROR;
    }
}


/* 检查产品更新,同步数据接口*/
-(NSDictionary *)GetEditedProductDataToServerInterface:(NSDictionary *)dictData
{
    //NSLog(@"%@",dictData);
    
    ReceiveDataFromService *data = [[ReceiveDataFromService alloc] init] ;
    
    NSString *str = [data CheckEditProductDataToServer:dictData];
    
    GetJson *json = [[GetJson alloc] init];
    
    NSDictionary *tempDic = [json parseTheJson:str];
    
    
    return tempDic;
    
}



@end
