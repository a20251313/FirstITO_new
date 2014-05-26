//
//  LixiCustomDizhiView.h
//  ShowCasePro
//
//  Created by Ran Jingfu on 5/15/14.
//  Copyright (c) 2014 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LixiCustomDizhiViewModel : NSObject<NSCoding>
@property(nonatomic)BOOL    chooseBashou;
@property(nonatomic)BOOL    chooseMengkuan;
@property(nonatomic)BOOL    chooseHeye;
@property(nonatomic)BOOL    chooseDingzhi;
@property(nonatomic)BOOL    chooseHuanbao;
@property(nonatomic)BOOL    chooseMoxuan;
@property(nonatomic,strong) NSDate  *storedate;
@end

@interface LixiCustomDizhiView : UIView


-(IBAction)closeAction:(UIButton*)sender;
-(IBAction)showBashouAction:(UIButton*)sender;
-(IBAction)showHeyeAction:(UIButton*)sender;
-(IBAction)showMoxuanAction:(UIButton*)sender;
-(IBAction)showMengkuanAction:(UIButton*)sender;
-(IBAction)showDingzhiAction:(UIButton*)sender;
-(IBAction)ShowHuanbaoAction:(UIButton*)sender;

@end
