//
//  CartViewCell.h
//  ShowCasePro
//
//  Created by lvpw on 14-3-11.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CartViewCell;

@protocol CartViewCellDelegate <NSObject>

- (void)tiaozhuanProduct:(CartViewCell *)cell;

@end

@interface CartViewCell : UITableViewCell

@property (weak, nonatomic) id<CartViewCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *countNumberLable;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UIView *selectView;
@property (strong, nonatomic) IBOutlet UIView *countView;
@property (strong, nonatomic) IBOutlet UIButton *imageButton;


@end
