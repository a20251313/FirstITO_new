//
//  FinderCell.h
//  InsertFinderDemo
//
//  Created by CY-004 on 13-11-18.
//  Copyright (c) 2013年 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FinderCell;

@protocol FinderCellDelegate <NSObject>

- (void)editFinderCellLabel:(FinderCell *)finderCell;
- (void)deleteFinderCell:(FinderCell *)finderCell;

@end

@interface FinderCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *folderImageView;
@property (nonatomic, strong) UILabel *folderNameView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, weak) id<FinderCellDelegate> delegate;

@end


