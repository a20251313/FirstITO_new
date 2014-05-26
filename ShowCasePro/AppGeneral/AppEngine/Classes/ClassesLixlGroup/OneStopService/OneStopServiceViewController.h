//
//  OneStopServiceViewController.h
//  ShowCasePro
//
//  Created by lvpw on 14-2-22.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilBaseViewController.h"

#import "iCarousel.h"

@interface OneStopServiceViewController : LixilBaseViewController

@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) IBOutlet UIView *twentyImageView;
- (IBAction)fanpanAction:(UIControl *)control;

@end
