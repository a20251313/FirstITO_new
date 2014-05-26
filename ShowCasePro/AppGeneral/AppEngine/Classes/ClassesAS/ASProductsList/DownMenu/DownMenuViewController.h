//
//  DownMenuViewController.h
//  ShowCasePro
//
//  Created by lvpw on 14-3-14.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DownMenuViewController;

@protocol DownMenuViewControllerDelegate <NSObject>

- (void)downMenu:(DownMenuViewController *)downMenuViewController DidSeletedAtIndex:(NSInteger)index;

@end

@interface DownMenuViewController : UIViewController

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, weak) id<DownMenuViewControllerDelegate> delegate;
@property (nonatomic) BOOL show;
@property (nonatomic) NSInteger buttontag;

- (void)showFromView:(UIView *)subView inView:(UIView *)view animated:(BOOL)animated;
- (void)dismiss;

@end
