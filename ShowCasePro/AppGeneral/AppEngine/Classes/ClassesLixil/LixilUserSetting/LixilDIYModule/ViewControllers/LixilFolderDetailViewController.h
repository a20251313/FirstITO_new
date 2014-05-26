//
//  FolderDetailViewController.h
//  ShowCasePro
//
//  Created by lvpw on 13-11-28.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "LixilBaseViewController.h"

@interface LixilFolderDetailViewController : LixilBaseViewController
- (IBAction)erweimashare:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *folderName;
@property (strong, nonatomic) IBOutlet UICollectionView *folderDetailCollectionView;
@property (strong, nonatomic) NSString *folderid;
@property (strong, nonatomic) NSString *foldername;

@end
