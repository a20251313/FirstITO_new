//
//  userGuideTips.h
//  ShowCasePro
//
//  Created by yczx on 14-4-29.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserGuideTips : NSObject
+ (id)shareInstance;

//提示tips
- (void)showUserGuideView:(UIView *)viewAddTipView tipKey:(NSString *)tipKey imageNamePre:(NSString*)imageNamePre;
@end
