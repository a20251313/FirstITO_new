//
//  FindersViewController.h
//  InsertFinderDemo
//
//  Created by CY-004 on 13-11-18.
//  Copyright (c) 2013年 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindersViewController : UICollectionViewController

@property (nonatomic, strong) NSMutableArray *folders;

- (void)addAction:(id)sender;
- (void)editAction:(id)sender;

@end
