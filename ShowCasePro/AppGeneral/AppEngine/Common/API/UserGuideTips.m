//
//  userGuideTips.m
//  ShowCasePro
//
//  Created by yczx on 14-4-29.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "UserGuideTips.h"

@implementation UserGuideTips
{
    UIImageView *_userGuideView;
    NSString *_currentViewVontrollerLaunchKey;

 
}

+ (id)shareInstance
{
    // 1.声明一个静态变量去保存类的实例，确保它在类中的全局可用性。
    static UserGuideTips *guideTip = nil;
    // 2.声明一个静态变量dispatch_once_t ,它确保初始化器代码只执行一次
    static dispatch_once_t oncePredicate;
    // 3.使用Grand Central Dispatch(GCD)执行初始化LibraryAPI变量的block.这  正是单例模式的关键：一旦类已经被初始化，初始化器永远不会再被调用。
    dispatch_once(&oncePredicate, ^{
        guideTip = [[UserGuideTips alloc] init];
    });
    return guideTip;
}

- (void)showUserGuideView:(UIView *)viewAddTipView tipKey:(NSString *)tipKey imageNamePre:(NSString *)imageNamePre{
    //某个页面需要提示的controller
    //每个页面进入的key不一样，存储的plist 文件也不一样
    _currentViewVontrollerLaunchKey = [NSString stringWithFormat:@"FirstLaunch%@",tipKey];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:_currentViewVontrollerLaunchKey] == nil) {
        _userGuideView = [[UIImageView alloc] initWithFrame:viewAddTipView.bounds];
        [_userGuideView setUserInteractionEnabled:YES];
        [viewAddTipView addSubview:_userGuideView];
        UITapGestureRecognizer *tapFirstView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFirstView:)];
        [_userGuideView addGestureRecognizer:tapFirstView];
        
    }
     [_userGuideView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",imageNamePre]]];
    
    
    
}
//点击很多次引导图片换完移除掉
- (void)removeFirstView:(UITapGestureRecognizer *)sender
{
    
        [UIView animateWithDuration:0.3 animations:^{
            [sender.view setAlpha:0.0];
        } completion:^(BOOL finished) {
            [sender.view removeFromSuperview];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:_currentViewVontrollerLaunchKey];
            
        }];
   
    
}

@end
