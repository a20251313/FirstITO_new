//
//  InaxVideoViewController
//  ShowCasePro
//
//  Created by lvpw on 14-2-18.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InaxBaseViewController.h"
typedef enum
{
    InaxVideoTypeEco_tech,
    InaxVideoTypeLejing_tech,
    InaxVideoTypeAirPush_tech,
    InaxVideoTypeShumoyugang,
    InaxVideoTypeMobileControl_tech
}InaxVideoType;
@interface InaxVideoViewController : InaxBaseViewController
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet UIButton *btnZhidao;
@property (strong, nonatomic) IBOutlet UIButton *btnYingyong;
@property (strong, nonatomic) IBOutlet UIImageView *videoImage;
@property (nonatomic) InaxVideoType videpType;
- (IBAction)playVideo:(id)sender;
//- (IBAction)changeVideo:(id)sender;

@end
