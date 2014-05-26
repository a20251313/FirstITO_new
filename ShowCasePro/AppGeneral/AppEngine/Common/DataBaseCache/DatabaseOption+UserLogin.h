//
//  DatabaseOption+UserLogin.h
//  ShowCasePro
//
//  Created by CY-003 on 13-12-18.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption.h"

@interface DatabaseOption (UserLogin)

- (BOOL) firstLogin;

- (BOOL) ifLogin;

- (Admin *) ifLoginSuccessWithUsername:(NSString *)username password:(NSString *)password;

@end
