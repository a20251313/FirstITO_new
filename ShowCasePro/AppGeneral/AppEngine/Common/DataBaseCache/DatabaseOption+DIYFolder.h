//
//  DatabaseOption+DIYFolder.h
//  ShowCasePro
//
//  Created by lvpw on 13-11-28.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption.h"
#import "Tdiyfolder.h"
#import "Tdiydetail.h"
#import "Tproduct.h"

@interface DatabaseOption (DIYFolder)

- (NSMutableArray *)selectAllFolders;
- (NSMutableArray *)selectAllFolderDetailsByFolderID:(NSString *)folderID;
- (BOOL)insertFolder:(Tdiyfolder *)diyfolder;
- (BOOL)updateFolderName:(NSString *)folderName ByFolderID:(NSString *)folderid;
- (BOOL)deleteFolderByFolderID:(NSString *)folderid;
- (BOOL)insertFolderDetail:(Tproduct *)product folderID:(NSString *)folderid;
// 分享操作
- (NSString *)selectShareStringByFolderID:(NSString *)folderID;
- (BOOL)insertFolderByShareString:(NSString *)shareString;

@end
