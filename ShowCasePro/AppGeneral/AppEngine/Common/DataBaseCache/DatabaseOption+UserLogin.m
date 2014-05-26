//
//  DatabaseOption+UserLogin.m
//  ShowCasePro
//
//  Created by CY-003 on 13-12-18.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+UserLogin.h"

@implementation DatabaseOption (UserLogin)

-(BOOL)firstLogin
{
    NSString *sql = @"select count(userid) from admin";
    
    FMResultSet *set = [self.fmdb executeQuery:sql];
    
    int count = 0;
    
    while ([set next])
    {
        count = [set intForColumnIndex:0];
    }
    
    if (count > 0)
    {
        return false;
    }
    
    return true;
}

-(BOOL)ifLogin
{
    NSDictionary *dic = [[LibraryAPI sharedInstance] getLocalValue:UserObject];
    
    if (dic)
    {
        return true;
    }
    
    return false;
}


-(Admin *)ifLoginSuccessWithUsername:(NSString *)username password:(NSString *)password
{
    if (!username || !username.length || !password || !password.length) {
        return false;
    }
    
    NSString *sql = [NSString stringWithFormat:@"select * from admin where username = '%@'",username];
    
    FMResultSet *set = [self.fmdb executeQuery:sql];
    
    Admin *admin = [Admin new];
    
    while ([set next])
    {
        admin.userid    = [set stringForColumn:@"userid"];
        admin.username  = [set stringForColumn:@"username"];
        admin.password  = [set stringForColumn:@"password"];
        admin.truename  = [set stringForColumn:@"truename"];
        admin.email     = [set stringForColumn:@"email"];
        admin.purview   = [set stringForColumn:@"purview"];
        admin.is_admin  = [set stringForColumn:@"is_admin"];
        admin.lastip    = [set stringForColumn:@"lastip"];
        admin.lastlogin = [set stringForColumn:@"lastlogin"];
        break;
    }
    
    if ([password isEqualToString:admin.password])
    {
        return admin;
    }
    
    return nil;
}

@end
