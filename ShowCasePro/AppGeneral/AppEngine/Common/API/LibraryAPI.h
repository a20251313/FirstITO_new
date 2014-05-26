//
//  LibiaryAPI.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-9.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Admin.h"

#define UserObject @"user_object"

@interface LibraryAPI : NSObject

@property (nonatomic, strong) NSString *currentBrandID; // 1.骊住 2.美标 3.依奈

@property (nonatomic, strong) Admin *currentUser; // 当前登录用户

@property (nonatomic, strong) UINavigationController *navgationController;

@property (nonatomic , strong) UIActivityIndicatorView *activityIndicator;

+ (LibraryAPI *) sharedInstance;

#pragma mark - Util

- (NSString *)NSDateToStringByFormatter:(NSString *)formatterString;

- (UIImage *)getImageFromPath:(NSString *)imagePath scale:(NSInteger)scale;
- (NSString *)downVideoByLink:(NSString *)link inView:(UIView *)view;
- (NSString *)getIPAddress;

//- ()

#pragma mark -
#pragma mark local data method

- (BOOL) isLocalDataExists:(NSString *)key;
- (void) setLocalData:(id)data key:(NSString *)key;
- (id) getLocalData:(NSString *)key;
- (void) setLocalValue:(id)value key:(NSString *)key;
- (void) setLocalInt:(int)value key:(NSString *)key;
- (void) setLocalBool:(bool)value key:(NSString *)key;
- (id) getLocalValue:(NSString *)key;
- (id) getLocalValueOnce:(NSString *)key;
- (int) getLocalInt:(NSString *)key;
- (bool) getLocalBool:(NSString *)key;
- (id) getLocalString:(NSString *)key;

#pragma mark -
#pragma mark file io method

- (NSMutableString *)getFullFileName:(NSString *) fileName;
- (bool)isFileExists:(NSString *)filepath;
- (NSMutableString *)getFileString: (NSString *) fileName;
- (bool)setFileString:(NSMutableString *) strSaving fileNameString:(NSString *) fileName;
- (NSData *)getFileData: (NSString *) fileName;
- (bool)setFileData:(NSObject *) dateSaving fileName:(NSString *) fileName;
- (NSData *)getData: (NSString *)fileName;
- (bool)setData:(NSData *) data fileName:(NSString *) fileName;
- (bool)setList:(NSMutableArray *) dataArray fileNameString:(NSString *) fileName;
- (NSMutableArray *)getList: (NSString *) fileName;
- (NSMutableArray *)dataToArray:(NSData *) data;
- (NSData *)arrayToData:(NSMutableArray *) dataArray;

#pragma mark -
#pragma mark 验证手机号

- (bool)isValidatePhone:(NSString *)mobileString;

#pragma mark -
#pragma mark Activity Indicatormethod

- (void) addActivityIndicatorToView:(UIView *)view;
- (void) removeActivityIndicatorFromSuperview;

#pragma mark -
#pragma mark show message method

- (void) showErrorMessage:(NSString *)messageText;
- (void) showHintMessage:(NSString *)messageText;

-(NSString *)dateToStr:(NSDate *)Date withFormat:(NSString *)formatStr;

#pragma mark --CustomerAnimation

+(void)playerAnimationWithObj:(UIImageView *)view withStateFrame:(CGRect)frame withPoint:(CGPoint)point;






@end
