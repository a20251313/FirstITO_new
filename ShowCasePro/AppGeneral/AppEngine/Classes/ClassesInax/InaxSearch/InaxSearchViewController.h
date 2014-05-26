//
//  InaxSearchViewController.h
//  ShowCasePro
//
//  Created by yczx on 14-4-14.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxBaseViewController.h"

@interface InaxSearchViewController : InaxBaseViewController

@property (nonatomic , strong) NSString *searchKeyWord;

- (void) reloadData;

@end
