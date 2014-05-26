//
//  UserSettingViewController.m
//  ShowCasePro
//
//  Created by yczx on 13-11-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "UserSettingViewController.h"
#import "LibraryAPI.h"
#import "AppConfig.h"
#import "Interface.h"
#import "DatabaseOption+Synchronization.h"
#import "ASDepthModalViewController.h"
#import <MBProgressHUD.h>
#import "Category.h"


@interface UserSettingViewController () <ASIProgressDelegate>
{
    
    IBOutlet UIImageView *bgImageView;
}

@property (nonatomic,strong) ASINetworkQueue *httpQueue;
@property (nonatomic, weak) UIButton *btn;
@property (nonatomic, strong) NSMutableArray *updateResults;
@property (nonatomic, strong) NSMutableArray *errorImageDownload;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) NSString *server_time;
@property BOOL b1;
@property BOOL b2;

@end

@implementation UserSettingViewController


- (IBAction)checkUpdate:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"当前已是最新版本"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
}


#pragma mark - ASIProgressDelegate

- (void)setProgress:(float)newProgress{
    self.HUD.progress = newProgress;
    self.HUD.labelText = [NSString stringWithFormat:@"正在下载图片 进度：%.0f%%", newProgress*100];
}

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    //    self.updateResults = [NSMutableArray array];
    //    self.errorImageDownload = [NSMutableArray array];
    _httpQueue =  [[ASINetworkQueue alloc]init];
    [self initHttpQueue];
    
    
    
    //根据品牌不同设置不同背景
    if ((![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"2"])&&(![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"])) //lixil
    {
        bgImageView.image = [UIImage imageNamed:@"lixil_uu_bg"];
    }
    else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"]) //inax
    {
        bgImageView.image = [UIImage imageNamed:@"lixil_uu_bg"];
    }
    else
    {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init

- (void)initHttpQueue{
    
    [_httpQueue setShouldCancelAllRequestsOnFailure:NO];
    [_httpQueue setDelegate:self];
    [_httpQueue setRequestDidFinishSelector:@selector(requestComplete:)];
    [_httpQueue setRequestDidFailSelector:@selector(requestFailed:)];
    [_httpQueue setQueueDidFinishSelector:@selector(queueComplete:)];
    [_httpQueue setRequestDidReceiveResponseHeadersSelector:@selector(request:didReceiveResponseHeaders:)];
}

- (void)initData{
    _b1 = NO;
    _b2 = NO;
    self.updateResults = [NSMutableArray array];
    self.errorImageDownload = [NSMutableArray array];
}

#pragma mark - Handle Action

- (IBAction)product_SycnBtnEvent:(id)sender
{
    [self initData];
    self.btn = sender;
    // 显示hud
    self.HUD = [[MBProgressHUD alloc] initWithView:self.parentViewController.view];
    [self.parentViewController.view addSubview:self.HUD];
    self.HUD.labelText = @"connecting...";
    [self.HUD show:YES];
    [self performSelector:@selector(updateFormServer) withObject:nil afterDelay:0.1];
}

- (IBAction)exit:(id)sender {
    [[LibraryAPI sharedInstance] setLocalValue:nil key:@"username"];
    [ASDepthModalViewController dismiss];
}

- (IBAction)clearDataBase:(id)sender {
//    [UIAlertView showWithTitle:@"删除数据库" message:@"确认删除？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
//        if (buttonIndex == 1) {
//            if ([[NSFileManager defaultManager] removeItemAtPath:[kDocuments stringByAppendingPathComponent:@"showcasedb.db"] error:nil]) {
//                [UIAlertView showAlertViewWithTitle:@"删除数据库成功" message:nil];
//            }
//        }
//    }];
}

#pragma mark - Util

- (void)updateFormServer{
    // 禁止button点击事件
    self.btn.enabled = NO;
    // 接收更新数据集列表
    NSDictionary *update_Dict;
    
    //     1. 调用同步接口返回需要同步的数据列表
    //  NSString *cur_Time = [[LibraryAPI sharedInstance] dateToStr:[NSDate date] withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //  [[LibraryAPI sharedInstance] setLocalValue:cur_Time key:LAST_SYCN_TIME];
    
    //NSString *last_Updatetime = [[LibraryAPI sharedInstance] getLocalValue:LAST_SYCN_TIME];
    
    NSDictionary *conDict = [NSDictionary dictionaryWithObjectsAndKeys:@"2013-01-01",@"sync_time",nil];
    
    NSDictionary *returnDict = [[Interface shareInstance] GetEditedProductDataToServerInterface:conDict];
    
    if ([returnDict objectForKey:CHECK_RESULT]) {
        if (![[returnDict objectForKey:RETURN_USER_DATA] isEqual:[NSNull null]]) {
            update_Dict = [returnDict objectForKey:RETURN_USER_DATA];
        }else{
            UIImage *image = [UIImage imageNamed:@"37x-Checkmark"];
            self.HUD.customView = [[UIImageView alloc] initWithImage:image];
            self.HUD.mode = MBProgressHUDModeCustomView;
            self.HUD.labelText = @"数据为空，不用更新";
            [self.HUD hide:YES afterDelay:2];
//            [[LibraryAPI sharedInstance] showHintMessage:@"数据为空。"];
            self.btn.enabled = YES;
            return;
        }
    }else{
        self.HUD.labelText = @"网络请求失败，检查网络链接。";
        [self.HUD hide:YES afterDelay:2];
//        [[LibraryAPI sharedInstance] showErrorMessage:@"网络请求失败，检查网络链接。"];
        self.btn.enabled = YES;
        return;
    }
    
    
    
    //     2. 收到需要同步的数据集后更新到本地数据库
    //    NSLog(@"update_Dict is %@", update_Dict);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        
        for (id akey in [update_Dict allKeys]) {
            NSString *t_name = akey;
            NSArray *itemList =  [update_Dict objectForKey:akey];
            //            NSLog(@"tname:>>%@, %@", t_name, itemList);
            //            if ([t_name isEqualToString:@"suites"]) {
            //                [self updateLocalDBByTitme:t_name withData:itemList];
            //            }
            
            [self updateLocalDBByTitme:t_name withData:itemList];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            __block NSString *temp = @"";
            [self.updateResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *tempDic = obj;
                temp = [temp stringByAppendingFormat:@"%@#total:%@, failed:%@\n", [tempDic objectForKey:@"TableName"], [tempDic objectForKey:@"TotalCount"], [tempDic objectForKey:@"ErrorCount"]];
            }];
            //mAlertView(@"数据库更新情况", temp);
            _b1 = YES;
            [self save];
        });
//        dispatch_async(dispatch_get_main_queue(), ^{
//            __block NSString *temp = @"";
//            [self.updateResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                NSDictionary *tempDic = obj;
//                temp = [temp stringByAppendingFormat:@"%@#total:%@, failed:%@\n", [tempDic objectForKey:@"TableName"], [tempDic objectForKey:@"TotalCount"], [tempDic objectForKey:@"ErrorCount"]];
//            }];
//            mAlertView(@"数据库更新情况", temp);
//            _b1 = YES;
//            [self save];
//        });
    });
    
    self.HUD.labelText = @"准备下载图片...";
    //     3. 根据当前要同步的数据集拼接产品素材路径下载产品素材。
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self.httpQueue reset];
        [self initHttpQueue];
        for (id akey in [update_Dict allKeys]) {
            NSString *t_name = akey;
            // 表名
            if ([t_name isEqualToString:@"tproduct"] ||
                [t_name isEqualToString:@"tmodule_pages"] ||
                [t_name isEqualToString:@"suites"] ||
                [t_name isEqualToString:@"tproduct_color_union"] ||
                [t_name isEqualToString:@"tproduct_color"]||
                [t_name isEqualToString:@"tmodule_setting"] ||
                [t_name isEqualToString:@"ttype"] ||
                [t_name isEqualToString:@"ttype_suites_union"] ||
                [t_name isEqualToString:@"tsuites_type"] ||
                [t_name isEqualToString:@"tsuite_space"] ||
                [t_name isEqualToString:@"tspace_images"] ||
                [t_name isEqualToString:@"tsuite_space"] ||
                [t_name isEqualToString:@"tvideo"] ||
                [t_name isEqualToString:@"tbrand_heritage"]  ||
                [t_name isEqualToString:@"tbrand_space"] ||
                [t_name isEqualToString:@"t_module_product"] ||
                [t_name isEqualToString:@"tnewproduct"] ||
                [t_name isEqualToString:@"t_inax_newproduct"] ||
                [t_name isEqualToString:@"t_inax_suites_collection"] ||
                [t_name isEqualToString:@"t_3d_product"] ||
                [t_name isEqualToString:@"t_3d_type"] ||
                [t_name isEqualToString:@"t_3d_room"])
            {
                NSArray *itemList =  [update_Dict objectForKey:akey];
                for (NSDictionary *dic in itemList) {
                    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                            NSString *link = (NSString *)obj;
                        if (![link isEqual:[NSNull null]]) {
                            // 字段链接
                            if ([link hasPrefix:@"data/productimage/"]) {
                                // 根据','分隔字符串
                                NSArray *arr = [link componentsSeparatedByString:@","];
                                for (NSString *str in arr) {
                                    if ([str hasPrefix:@"data/productimage/"]) {
                                        [self addRequestToQueueByURL:str];
                                    }
                                }
//                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"data/Inax_ico/"]) {
                                // 根据','分隔字符串
                                NSArray *arr = [link componentsSeparatedByString:@","];
                                for (NSString *str in arr) {
                                    if ([str hasPrefix:@"data/Inax_ico/"]) {
                                        [self addRequestToQueueByURL:str];
                                    }
                                }
                            } else if ([link hasPrefix:@"data/mbxinghao"]) {
                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"data/lixilshuoming"]) {
                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"data/lixilgroup"]) {
                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"data/brandimage"]) {
                                // 根据','分隔字符串
                                NSArray *arr = [link componentsSeparatedByString:@","];
                                for (NSString *str in arr) {
                                    if ([str hasPrefix:@"data/brandimage/"]) {
                                        [self addRequestToQueueByURL:str];
                                    }
                                }
//                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"data/colorimage/brand_lixil"]) {
                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"data/colorunionimage"]) {
                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"data/brand_main"]) {
                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"data/brand_type"]) {
                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"data/type_suites_ico"]) {
                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"data/tbrand_heritage"]) {
                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"data/inax"]) {
                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"data/lixil"]) {
                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"data/product3d"]) {
                                [self addRequestToQueueByURL:link];
                            } else if ([link hasPrefix:@"product_3d_images_"]) //3d图片前缀
                            {
                                //手动拼接3d图片的下载路径
                                for (int i = 0; i < Product_3D_Image_Count; i++)
                                {
                                    NSString *temp = [NSString stringWithFormat:@"data/product3d/images/%@%d.png",link,i];
                                    [self addRequestToQueueByURL:temp];
                                }
                            }
                        }
                    }];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.httpQueue setDownloadProgressDelegate:self];
            [self.httpQueue go];
            self.HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
            self.HUD.labelText = @"开始下载图片...";
        });
    });
    
    //     4. 下载完成后记录服务器更新时间。
    self.server_time = [returnDict objectForKey:@"server_time"];
    //     5. 处理更新完成后事件
}

- (void)addRequestToQueueByURL:(NSString *)link
{
    NSString *image_Path_Client = [kLibrary stringByAppendingFormat:@"/%@", link];
    //                            NSLog(@"%@", image_Path_Client);
    UIImage *image = [UIImage imageWithContentsOfFile:image_Path_Client];
    if (image == nil) {
        // 创建文件
        [[NSFileManager defaultManager] createDirectoryAtPath:[image_Path_Client stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *image_Path_Server = [SERVER_PRO_PATH stringByAppendingString:link];
        // 显示转换URL，防止中文字符和空格导致的解析错误
        ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[image_Path_Server stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [request setTimeOutSeconds:30];
//        [request setShowAccurateProgress:YES];
        [request setUserInfo:@{@"TargetPath": image_Path_Client}];
        // 设置下载目标地址
        [request setDownloadDestinationPath:image_Path_Client];
        [request setDelegate:self];
        [self.httpQueue addOperation:request];
    }
}

-(void)updateLocalDBByTitme:(NSString *)tName withData:(NSArray *)data
{
    NSMutableArray *errorData = [NSMutableArray array];
    // 执行update操作
    DatabaseOption *dbo = [[DatabaseOption alloc]init];
    // 12月15日：采用事务处理插入 每张表一次事务  begin
    [dbo.fmdb beginTransaction];
    BOOL isRollBack = NO;
    @try {
        [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *dic = (NSDictionary *)obj;
            
            //admin表是userid  防止取到null造成删不掉旧数据
            NSString *table_id = [dic objectForKey:@"id"];
            
            if (!table_id) {
                table_id = [dic objectForKey:@"userid"];
            }
            
            [dbo deleteDataByID:table_id inTable:tName];
            
            if (![dbo insertIntoTable:tName withParams:dic]) {
                [errorData addObject:dic];
            }
        }];
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        [dbo.fmdb rollback];
    }
    @finally {
        if (!isRollBack) {
            [dbo.fmdb commit];
        }
    }
    // 12月15日：采用事务处理插入 每张表一次事务   end
    
    //    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    //        NSDictionary *dic = (NSDictionary *)obj;
    //        [dbo deleteDataByID:[dic objectForKey:@"id"] inTable:tName];
    //        if (![dbo insertIntoTable:tName withParams:dic]) {
    //            [errorData addObject:dic];
    //        }
    //    }];
    
    // 存储update结果信息
    NSMutableDictionary *dataBase = [NSMutableDictionary dictionary];
    [dataBase setObject:tName forKey:@"TableName"];
    [dataBase setObject:[NSString stringWithFormat:@"%d", [data count]] forKey:@"TotalCount"];
    [dataBase setObject:[NSString stringWithFormat:@"%d", [errorData count]] forKey:@"ErrorCount"];
    [dataBase setObject:errorData forKey:@"ErrorData"];
    [self.updateResults addObject:dataBase];
}

- (void)save{
    NSLog(@"All Completed!");
    // 更新完成(无错误)记录时间
    [[LibraryAPI sharedInstance] setLocalData:self.server_time key:LAST_SYCN_TIME];
    // 数据库更新操作和下载图片操作都完成之后将更新结果情况存储本地
    if (_b1 && _b2) {
        [[LibraryAPI sharedInstance] setLocalValue:self.updateResults key:@"updateResults"];
        _b1 = NO;
        _b2 = NO;
        UIImage *image = [UIImage imageNamed:@"37x-Checkmark"];
        self.HUD.customView = [[UIImageView alloc] initWithImage:image];
        self.HUD.mode = MBProgressHUDModeCustomView;
        self.HUD.labelText = @"下载图片完成";
        [self.HUD hide:YES afterDelay:2];
    }
}

#pragma mark - ASINetworkQueue call back

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
//    NSLog(@"%@", [responseHeaders objectForKey:@"Content-Length"]);
//    NSLog(@"%@, %@", responseHeaders, request.downloadDestinationPath);
}

// 执行下载事件方法
-(void)requestComplete:(ASIHTTPRequest *)request
{
//    NSLog(@"Complete:%@\n", [[request userInfo] objectForKey:@"TargetPath"]);
}

// 单个请求失败时回调方法
-(void)requestFailed:(ASIHTTPRequest *)request
{
    if (![self.errorImageDownload containsObject:[[request userInfo] objectForKey:@"TargetPath"]]) {
        [self.errorImageDownload addObject:[[request userInfo] objectForKey:@"TargetPath"]];
    }
    NSLog(@"Failed:%@\n TargetPath:%@", [request error], [[request userInfo] objectForKey:@"TargetPath"]);
}

//下载队列执行完整回调方法
-(void)queueComplete:(ASINetworkQueue *)queue
{
    // 存储update结果信息
    NSMutableDictionary *dataBase = [NSMutableDictionary dictionary];
    [dataBase setObject:@"ImageDownload" forKey:@"TableName"];
    [dataBase setObject:[NSString stringWithFormat:@"%.0llu", queue.totalBytesToDownload] forKey:@"TotalCount"];
    [dataBase setObject:[NSString stringWithFormat:@"%d", [self.errorImageDownload count]] forKey:@"ErrorCount"];
    [dataBase setObject:self.errorImageDownload forKey:@"ErrorData"];
    [self.updateResults addObject:dataBase];
    
    self.btn.enabled = YES;
    _b2 = YES;
    [self save];
}

@end
