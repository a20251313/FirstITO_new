//
//  AppDelegate.h
//  ShouGouAPP
//
//  Created by yczx on 13-3-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetJson : NSObject

/*json返回的是一个字典*/
- (NSMutableDictionary *)parseTheJson:(NSString *)content;
/*json返回的是一个数组*/
- (NSMutableArray *)parseTheJsonArr:(NSString *)content;
@end
