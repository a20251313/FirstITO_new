//
//  ProvinceCityMenuViewController.h
//  ShowCasePro
//
//  Created by lvpw on 14-2-20.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProvinceCityMenuViewController;
@protocol ProvinceCityMenuViewControllerDelegate <NSObject>

- (void)provinceCityMenuViewController:(ProvinceCityMenuViewController *)provinceCityMenuViewController didSelectedIndex:(NSInteger)index;

@end

@interface ProvinceCityMenuViewController : UIViewController

@property (nonatomic, strong) NSArray *menuData;
@property (nonatomic, strong) NSString *type;
@property BOOL isShow;
@property (strong, nonatomic) IBOutlet UITableView *provinceCityTableView;
@property (nonatomic, weak) id<ProvinceCityMenuViewControllerDelegate> delegate;

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated;

@end
