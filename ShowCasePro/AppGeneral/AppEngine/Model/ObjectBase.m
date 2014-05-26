//
//  ObjectBase.m
//  ShowCasePro
//
//  Created by lvpw on 13-12-10.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "ObjectBase.h"
#import <objc/message.h>

@implementation ObjectBase

- (NSDictionary *)dictionary
{
    @try {
        NSDictionary *dic = nil;
        if (!_keys) {
            unsigned int outCount, i;
            objc_property_t *properties = class_copyPropertyList([self class], &outCount);
            NSMutableArray *tempKeys = [[NSMutableArray alloc] initWithCapacity:outCount];
            for (i = 0; i < outCount; i++) {
                objc_property_t property = properties[i];
                
                NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                
                [tempKeys addObject:key];
            }
            self.keys = tempKeys;
        }
        dic = [self dictionaryWithValuesForKeys:self.keys];
        return dic;
    }
    @catch (NSException *exception) {
        NSLog(@"Warning: %@ Class dictionary exception: %@",[self class],[exception debugDescription]);
    }
}

@end
