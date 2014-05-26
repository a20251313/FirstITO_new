//
//  CartViewCell.m
//  ShowCasePro
//
//  Created by lvpw on 14-3-11.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "CartViewCell.h"

@implementation CartViewCell

- (IBAction)tapProductAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(tiaozhuanProduct:)]) {
        [self.delegate tiaozhuanProduct:self];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
