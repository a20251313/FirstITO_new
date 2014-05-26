//
//  RetailStoresTableViewCell.h
//  ShowCasePro
//
//  Created by lvpw on 14-2-20.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RetailStoresTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextView *storeTextView;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *address;

@end
