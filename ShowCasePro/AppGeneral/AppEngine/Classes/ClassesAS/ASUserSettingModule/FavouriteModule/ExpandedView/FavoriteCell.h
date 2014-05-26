//
//  Cell.h
//  CellDemo
//
//  Created by CY-004 on 13-11-19.
//  Copyright (c) 2013年 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FavoriteCell;

@protocol DeleteCellProtocol <NSObject>

- (void)deleteCell:(FavoriteCell *)cell;

@end

@interface FavoriteCell : UICollectionViewCell

@property (nonatomic, strong)UIButton *deleteBtn;
@property (nonatomic, weak)id<DeleteCellProtocol> delegate;
@property (nonatomic, strong) UIImageView *imageView;

@end
