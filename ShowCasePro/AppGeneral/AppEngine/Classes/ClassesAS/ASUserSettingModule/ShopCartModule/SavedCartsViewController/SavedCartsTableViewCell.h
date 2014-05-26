//
//  SavedCartsTableViewCell.h
//  ShowCasePro
//
//  Created by lvpw on 14-3-10.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SavedCartsTableViewCell;

@protocol SavedCartsTableViewCellDelegate <NSObject>

- (void)pleaseRemoveSavedCartInCell:(SavedCartsTableViewCell *)cell;

@end

@interface SavedCartsTableViewCell : UITableViewCell

@property (weak, nonatomic) id<SavedCartsTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *dateText;
@property (weak, nonatomic) IBOutlet UILabel *remarkText;

@end
