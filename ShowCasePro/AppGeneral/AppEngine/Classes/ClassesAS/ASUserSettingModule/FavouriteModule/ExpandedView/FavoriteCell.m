//
//  Cell.m
//  CellDemo
//
//  Created by CY-004 on 13-11-19.
//  Copyright (c) 2013年 CY. All rights reserved.
//

#import "FavoriteCell.h"

@implementation FavoriteCell

- (void)deleteCell:(id)sender
{
    [_delegate deleteCell:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 80, 60)];
        self.imageView = imageView;
        [self.contentView addSubview:imageView];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        deleteBtn.hidden = YES;
        _deleteBtn = deleteBtn;
//        deleteBtn.backgroundColor = [UIColor greenColor];
        
        //根据品牌不同设置不同背景
        if ((![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"2"])&&(![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"])) //lixil
        {
            [deleteBtn setBackgroundImage:[UIImage imageNamed:@"diy_delete"] forState:UIControlStateNormal];
        }
        else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"]) //inax
        {
            [deleteBtn setBackgroundImage:[UIImage imageNamed:@"inax_diy_delete"] forState:UIControlStateNormal];
        }
        else
        {
            [deleteBtn setBackgroundImage:[UIImage imageNamed:@"diy_delete"] forState:UIControlStateNormal];
        }
        
        
        [deleteBtn addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteBtn];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
