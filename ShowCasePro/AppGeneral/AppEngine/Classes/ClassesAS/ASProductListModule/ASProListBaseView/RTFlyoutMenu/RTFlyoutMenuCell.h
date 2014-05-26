//
//  RTFlyoutMenuCell.h
//  ShowCasePro
//
//  Created by yczx on 14-3-10.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTFlyoutItem.h"

@interface RTFlyoutMenuCell : UITableViewCell


@property (weak, nonatomic) IBOutlet RTFlyoutItem *menuItem;

@property (weak, nonatomic) IBOutlet UIView *ItemBottomLine;



@end
