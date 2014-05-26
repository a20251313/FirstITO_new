//
//  ASMenuViewController.h
//  UIPopViewDemo
//
//  Created by lvpw on 14-2-13.
//  Copyright (c) 2014年 lvpw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASMenuViewControllerDelegate <NSObject>

- (void)asMenuViewControllerDidSelectedViewControllerName:(NSString *)viewControllerName;

@end

@interface ASMenuViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) id<ASMenuViewControllerDelegate> delegate;

@end
