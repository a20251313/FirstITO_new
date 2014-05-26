//
//  SavedCartsViewController.h
//  ShowCasePro
//
//  Created by lvpw on 14-3-10.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Torder;
@protocol SavedCartsViewControllerDelegate <NSObject>

- (void)didSelectedSavedCart:(Torder *)order;

@end

@interface SavedCartsViewController : UIViewController

@property (weak, nonatomic) id<SavedCartsViewControllerDelegate> delegate;

@end
