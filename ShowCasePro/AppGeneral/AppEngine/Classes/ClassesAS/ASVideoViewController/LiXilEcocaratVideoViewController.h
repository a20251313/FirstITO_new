//
//  ASVideoViewController.h
//  ShowCasePro
//
//  Created by lvpw on 14-2-18.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ASVideoViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet UIImageView *videoImage;
- (IBAction)playVideo:(id)sender;
//- (IBAction)changeVideo:(id)sender;

@end
