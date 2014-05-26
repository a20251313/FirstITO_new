//
//  FinderCell.m
//  InsertFinderDemo
//
//  Created by CY-004 on 13-11-18.
//  Copyright (c) 2013年 CY. All rights reserved.
//

#import "FinderCell.h"

@implementation FinderCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code  CGRectMake(20, 0, 31, 31)
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 79, 77)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"diy_folder"];
        // CGRectMake(0, 35, 70, 15)
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 100, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = mRGBColor(106., 106., 106.);
        label.font = [UIFont systemFontOfSize:18.f];
        label.textAlignment = NSTextAlignmentCenter;
        
        CGPoint center = label.center;
        center.x = imageView.center.x;
        label.center = center;
        
        UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
//        left.backgroundColor = [UIColor colorWithRed:220./255 green:220./255 blue:220./255 alpha:1];
//        [left setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
//        [left setTitle:@"D" forState:UIControlStateNormal];
        [left setImage:[UIImage imageNamed:@"diy_delete"] forState:UIControlStateNormal];
        [left setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [left addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.hidden = YES;
//        UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, 20, 20)];//CGRectMake(57, 0, 15, 15)
////        right.backgroundColor = [UIColor colorWithRed:220./255 green:220./255 blue:220./255 alpha:1];
//        [right setTitle:@"E" forState:UIControlStateNormal];
//        [right setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
////        [right setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
//        [right addTarget:self action:@selector(editLabel:) forControlEvents:UIControlEventTouchUpInside];
//        _rightButton.hidden = YES;
        
        self.leftButton = left;
//        self.rightButton = right;
        self.folderImageView = imageView;
        self.folderNameView = label;
        [self.contentView addSubview:self.folderImageView];
        [self.contentView addSubview:self.folderNameView];
        [self.contentView addSubview:self.leftButton];
//        [self.contentView addSubview:self.rightButton];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)editLabel:(id)sender
{
    [_delegate editFinderCellLabel:self];
}

- (void)deleteCell:(id)sender
{
    [_delegate deleteFinderCell:self];
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
