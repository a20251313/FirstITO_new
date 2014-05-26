//
//  AppDelegate.h
//  ShouGouAPP
//
//  Created by yczx on 13-3-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "GetJson.h"
#import "SBJson.h"

@implementation GetJson

- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialization code here.
    }
    
    return self;
}

////json返回的是一个字典
- (NSMutableDictionary *)parseTheJson:(NSString *)content
{
    NSMutableDictionary *jsonContent;
    jsonContent = [content JSONValue];
    return jsonContent;
}
//
////json返回的是一个数组
- (NSMutableArray *)parseTheJsonArr:(NSString *)content
{
    NSMutableArray *jsonContent;
    jsonContent = [content JSONValue];
    return jsonContent;
}
@end
