//
//  SavedCartsTableViewCell.m
//  ShowCasePro
//
//  Created by lvpw on 14-3-10.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "SavedCartsTableViewCell.h"

@implementation SavedCartsTableViewCell

- (IBAction)removeSavedCart:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(pleaseRemoveSavedCartInCell:)]) {
        [self.delegate pleaseRemoveSavedCartInCell:self];
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
