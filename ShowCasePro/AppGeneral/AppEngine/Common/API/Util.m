//
//  AppDelegate.h
//  ShouGouAPP
//
//  Created by yczx on 13-3-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "Util.h"


@implementation Util

+ (id)shareInstance
{
    // 1.声明一个静态变量去保存类的实例，确保它在类中的全局可用性。
    static Util *gUtil = nil;
    // 2.声明一个静态变量dispatch_once_t ,它确保初始化器代码只执行一次
    static dispatch_once_t oncePredicate;
    // 3.使用Grand Central Dispatch(GCD)执行初始化LibraryAPI变量的block.这  正是单例模式的关键：一旦类已经被初始化，初始化器永远不会再被调用。
    dispatch_once(&oncePredicate, ^{
        gUtil = [[Util alloc] init];
    });
    return gUtil;
}



- (UIImage *)changeNSDateToImage:(NSData *)srcData
{
    UIImage *image = [[UIImage alloc]init];
    image = [UIImage imageWithData:srcData];
    
    return image;
}


- (NSString *)stringToMD5:(NSString *)src
{
   // const char *cStr = [src UTF8String];
    unsigned char result[32];
  //  CC_MD5( cStr, strlen(cStr), result );
    
    NSString *endStr = [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];

    return endStr;
}

/*判断数据是否为NSNull*/
- (NSString *)checkNullString:(NSString *)src
{
    NSString *endStr = src;
    if ([endStr isEqual:[NSNull null]]) {
        endStr = @"";
    }
    
    return endStr;

}


/*判断数据是否为NSNull 转化为Int*/
- (NSString *)checkNullASIntToZero:(NSString *)src
{
    NSString *endStr = src;
    if ([src isEqual:[NSNull null]]) {
        endStr = @"0";
    }
    
    return endStr;
    
}


- (UIImage *)imageFromURL:(NSString *)imgURl
{
    NSURL *url = [NSURL URLWithString:imgURl];

    NSData *imageData = [NSData dataWithContentsOfURL:url];

    UIImage *image = [UIImage imageWithData:imageData];
    
    return image;
}

- (CATransition *)transitionFromLeft
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:1.0];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setType:@"oglFlip"];
    [animation setSubtype: kCATransitionFromLeft];
    [animation setFillMode:kCAFillModeForwards];
    return animation;
}


- (CATransition *)transitionFromRight
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:1.0];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setType:@"oglFlip"];
    [animation setSubtype: kCATransitionFromRight];
    [animation setFillMode:kCAFillModeForwards];
    return animation;
}

@end
