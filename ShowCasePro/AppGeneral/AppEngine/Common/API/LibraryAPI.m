//
//  LibiaryAPI.m
//  ShowCasePro
//
//  Created by lvpw on 13-12-9.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "LibraryAPI.h"
#import "Category.h"
#import "MacroDefine.h"
#import "HTTPClient.h"

// 消息相关
#define ALERT_TITLE_ERROR @"出错提示"
#define ALERT_TITLE_HINT @"提 示"
#define ALERT_BUTTON_CONFIRM @"确定"
#define ALERT_BUTTON_CANCEL @"确定"

@interface LibraryAPI ()

@property (nonatomic, strong) HTTPClient *httpClient;

@end

@implementation LibraryAPI

@synthesize currentUser = _currentUser;

+ (LibraryAPI *) sharedInstance
{
    // 1.声明一个静态变量去保存类的实例，确保它在类中的全局可用性。
    static LibraryAPI *_sharedInstance = nil;
    // 2.声明一个静态变量dispatch_once_t ,它确保初始化器代码只执行一次
    static dispatch_once_t oncePredicate;
    // 3.使用Grand Central Dispatch(GCD)执行初始化LibraryAPI变量的block.这  正是单例模式的关键：一旦类已经被初始化，初始化器永远不会再被调用。
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LibraryAPI alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Util

- (NSString *)NSDateToStringByFormatter:(NSString *)formatterString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = formatterString;
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    return [formatter stringFromDate:[NSDate date]];
}

#pragma mark - override

//- (NSString *)currentBrandID
//{
//    return @"2";
//}

- (Admin *)currentUser
{
    // 初始化当前登录用户
    if (!_currentUser) {
        NSDictionary *dic = [self getLocalValue:UserObject];
        Admin *user = [[Admin alloc]init];
        [user setValuesForKeysWithDictionary:dic];
        _currentUser = user;
    }
    return _currentUser;
}

- (UIImage *)getImageFromPath:(NSString *)imagePath scale:(NSInteger)scale
{
    if (scale==1) {
//        NSLog(@"%@", [kLibrary stringByAppendingFormat:@"/%@", imagePath]);
        return [UIImage imageWithContentsOfFile:[kLibrary stringByAppendingFormat:@"/%@", imagePath]];
    }
    // 获取路径
    NSString *savedImagePath = [kLibrary stringByAppendingFormat:@"/%d/%@", scale, imagePath];
    // 读取小图
    UIImage *endImage = [UIImage imageWithContentsOfFile:savedImagePath];
    // 如果小图为空 读取大图压缩
    if (endImage == nil) {
        // 读取原尺寸图片
        UIImage *image = [UIImage imageWithContentsOfFile:[kLibrary stringByAppendingFormat:@"/%@", imagePath]];
        // 缩放
        endImage = [UIImage scaleImage:image toSize:CGSizeMake(image.size.width/scale, image.size.height/scale)];
        
        // 将缩小的图片缓存到本地 以缩小倍数建一个文件夹
        // 找出目录
        NSString *path = [savedImagePath stringByDeletingLastPathComponent];
//        do {
//            path = [path substringToIndex:path.length-1];
//        } while ([path characterAtIndex:path.length-1] != '/');
//        path = [path substringToIndex:path.length-1];
        if (![[NSFileManager defaultManager]fileExistsAtPath:path]) {
            // 文件夹不存在 建文件夹
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        }
        // 存储
        [UIImagePNGRepresentation(endImage) writeToFile:savedImagePath options:NSAtomicWrite error:nil];
    }
    return endImage;
}

- (NSString *)downVideoByLink:(NSString *)link inView:(UIView *)view
{
    return [self.httpClient downVideoByLink:link inView:view];
}

- (NSString *)getIPAddress
{
    return [self.httpClient getIPAddress];
}

#pragma mark -
#pragma mark local data method


- (BOOL) isLocalDataExists:(NSString *)key{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	return [ud objectForKey:key] != NULL;
}

- (void) setLocalData:(id)data key:(NSString *)key{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	if (data == nil) {
		[ud removeObjectForKey:key];
	}
	else {
		NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:data];
		[ud setObject:userData forKey:key];
	}
	[ud synchronize];
}


- (id) getLocalData:(NSString *)key{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	if ([ud objectForKey:key] != NULL) {
		NSData *userData = [ud objectForKey:key];
		return [NSKeyedUnarchiver unarchiveObjectWithData:userData];
	}
	else {
		return nil;
	}
    
}

- (void) setLocalValue:(id)value key:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	if (value == nil) {
		[ud removeObjectForKey:key];
	}
	else {
		[ud setObject:value forKey:key];
	}
	[ud synchronize];
}

- (void) setLocalInt:(int)value key:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	[ud setInteger:value forKey:key];
	[ud synchronize];
}

- (void) setLocalBool:(bool)value key:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	[ud setBool:value forKey:key];
	[ud synchronize];
}


- (id) getLocalValue:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	return [ud objectForKey:key];
}

- (int) getLocalInt:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	return [ud integerForKey:key];
}

- (bool) getLocalBool:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	return [ud boolForKey:key];
}

- (id) getLocalString:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	return [ud stringForKey:key];
}



- (id) getLocalValueOnce:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	id returnValue = [ud objectForKey:key];
	[ud removeObjectForKey:key];
	[ud synchronize];
	return returnValue;
}



#pragma mark -
#pragma mark file io method

- (NSMutableString *)getFullFileName:(NSString *) fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *path = [paths objectAtIndex:0];
	NSString *fileString = [path stringByAppendingPathComponent:fileName];
	return [NSMutableString stringWithString: fileString];
}

- (bool)isFileExists:(NSString *)filepath {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	return [fileManager fileExistsAtPath:filepath];
}

- (NSMutableString *)getFileString: (NSString *) fileName {
	
	NSMutableString *dataString;
	
	if ([self isFileExists:[self getFullFileName:fileName]]) {
		NSData *data = [[NSData alloc] initWithContentsOfFile:[self getFullFileName:fileName]];
		dataString = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	}
	else {
		dataString = [NSMutableString stringWithString:@""];
	}
    
	return dataString;
}

- (bool)setFileString:(NSMutableString *) strSaving fileNameString:(NSString *) fileName {
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:strSaving];
	return ([data writeToFile:[self getFullFileName:fileName] atomically:YES]);
}

- (NSData *)getFileData: (NSString *) fileName {
	
	NSData *dataSaved;
	
	if ([self isFileExists:[self getFullFileName:fileName]]) {
		NSData *data = [[NSData alloc] initWithContentsOfFile:[self getFullFileName:fileName]];
		dataSaved = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	}
	else {
		dataSaved = [NSData data];
	}
	
	return dataSaved;
}

- (bool)setFileData:(NSObject *) dateSaving fileName:(NSString *) fileName {
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dateSaving];
	return ([data writeToFile:[self getFullFileName:fileName] atomically:YES]);
}

- (NSData *)getData: (NSString *)fileName {
	
	NSData *data;
	
	if ([self isFileExists:[self getFullFileName:fileName]]) {
		data = [[NSData alloc] initWithContentsOfFile:[self getFullFileName:fileName]];
	}
	else {
		data = [NSData data];
	}
	
	return data;
}

- (bool)setData:(NSData *) data fileName:(NSString *) fileName {
	return ([data writeToFile:[self getFullFileName:fileName] atomically:YES]);
}

- (bool)setList:(NSMutableArray *) dataArray fileNameString:(NSString *) fileName {
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
	return ([data writeToFile:[self getFullFileName:fileName] atomically:YES]);
}

- (NSMutableArray *)getList: (NSString *) fileName {
	NSData *data = [[NSData alloc] initWithContentsOfFile:[self getFullFileName:fileName]];
	NSMutableArray *dataArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	return dataArray;
}

- (NSMutableArray *)dataToArray:(NSData *) data {
	NSMutableArray *dataArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	return dataArray;
}

- (NSData *)arrayToData:(NSMutableArray *) dataArray {
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
	return data;
}

#pragma mark -
#pragma mark 验证手机号
// 判断手机号是否有效
- (bool)isValidatePhone:(NSString *)mobileString {
    
    if (mobileString == nil) {
        
        return NO;
    }
    
    NSMutableString *testString=[NSMutableString stringWithString:mobileString];
    
    //一个判断是否是有效的手机号码正则表达式
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^(13[0-9]|15[0-3]|15[5-9]|145|147|18[0-9])[0-9]{8}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    
    //无符号整型数据接受匹配的数据的数目
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:testString
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, testString.length)];
    
    if(numberofMatch > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

#pragma mark -
#pragma mark Activity Indicator method

-(id)init
{
    self = [super init];
    
    if (self) {
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activityIndicator.frame = CGRectMake(0, 0, 100, 100);
        self.activityIndicator.backgroundColor = [UIColor blackColor];
        self.activityIndicator.layer.cornerRadius = 10;
        self.activityIndicator.layer.masksToBounds = YES;
        self.httpClient = [[HTTPClient alloc] init];
    }
    return self;
}


-(void)addActivityIndicatorToView:(UIView *)view
{
    self.activityIndicator.alpha = 0;
    [self.activityIndicator startAnimating];
    [view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2 - 30);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.activityIndicator.alpha = 0.6;
    }];
}

-(void)removeActivityIndicatorFromSuperview
{
    [UIView animateWithDuration:0.5 animations:^{
        self.activityIndicator.alpha = 0;
    } completion:^(BOOL finished) {
        [self.activityIndicator stopAnimating];
        [self.activityIndicator removeFromSuperview];
    }];
}

#pragma mark -
#pragma mark show message method

- (void) showErrorMessage:(NSString *)messageText{
    
    if (messageText == nil) {
        return;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:ALERT_TITLE_ERROR
                                                        message:messageText
                                                       delegate:nil
                                              cancelButtonTitle:ALERT_BUTTON_CONFIRM
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void) showHintMessage:(NSString *)messageText{
    
    if (messageText == nil) {
        return;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:ALERT_TITLE_HINT
                                                        message:messageText
                                                       delegate:nil
                                              cancelButtonTitle:ALERT_BUTTON_CONFIRM
                                              otherButtonTitles:nil];
    [alertView show];
}


-(NSString *)dateToStr:(NSDate *)Date withFormat:(NSString *)formatStr
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:Date];
    //输出格式为：09:20PM
    // NSLog(@"%@",currentDateStr);
    
    return currentDateStr;
}

@end
