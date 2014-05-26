//
//  HTTPClient.h
//  ShowCasePro
//
//  Created by lvpw on 14-1-3.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPClient : NSObject

- (NSString *)downVideoByLink:(NSString *)link inView:(UIView *)view;
- (NSString *)getIPAddress;

@end
