//
//  DataFromService.m
//  TXFishing
//
//  Created by chen mj on 12-10-24.
//  Copyright (c) 2012年 chen mj. All rights reserved.
//

#import "ReceiveDataFromService.h"
#import "ASIFormDataRequest.h"
#import "Util.h"
#import "AppConfig.h"


@interface ReceiveDataFromService (ppp)

//初始化一些固有的基本信息
- (void)applicationInfo;

//将请求的参数用MD5加密，中间增加MAC_KEY
- (NSString *)requestInfoToMD5:(NSString *)src;

@end


@implementation ReceiveDataFromService

@synthesize appVersion = _appVersion;
@synthesize appDeviceToken = _appDeviceToken;




- (id)init
{
    self = [super init];
    
    if (self) {
        [self applicationInfo];
    }
    return self;
}

- (void)applicationInfo
{

    self.appVersion = @"";//APP_VERSION;
    
    //self.appDeviceToken = @"orefmfldkfjsdfksdkfsjdfsdfsdfj234234234jkdk";

}

- (NSString *)requestInfoToMD5:(NSString *)src
{
    NSString *endString = @"";
    NSString *temp = [src stringByAppendingFormat:@"MAC_KEY=%@",@""];//macKey
    ////NSLog(@"--- >>  \n%@", temp);
    endString = [[Util shareInstance]stringToMD5:temp];
    
    return endString;
}



/* 检查产品更新,同步数据接口*/
- (NSString *)CheckEditProductDataToServer:(NSDictionary *)dictData
{
    NSString *content;
    
    NSURL *url=[NSURL URLWithString:FUN_SYNC_PRODUCT_DATA];
    
    //NSLog(@"---------_URL is %@",url);
    
	ASIFormDataRequest *request=[[ASIFormDataRequest alloc] initWithURL:url];
	[request setRequestMethod:@"POST"];
   	//执行发起请求,将来还要就收服务器的数据
 //   [request addRequestHeader:@"Authorization" value:@""];
    [request addPostValue:[dictData objectForKey:@"sync_time"] forKey:@"sync_time"];
    
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
   	[request startSynchronous];//start方法会启动request的main(),只要执行到这一行,就会有反应了
	//通讯和解析
	content=[request responseString];//这个方法返回一个属性,这个属性就是内容
    
  //  NSLog(@"----->%@",content);
    
    return content;
    
}


@end
