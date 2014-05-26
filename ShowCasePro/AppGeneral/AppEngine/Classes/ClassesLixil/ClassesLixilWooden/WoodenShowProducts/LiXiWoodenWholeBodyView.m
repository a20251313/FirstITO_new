//
//  LiXiWoodenWholeBodyView.m
//  ShowCasePro
//
//  Created by Ran Jingfu on 5/17/14.
//  Copyright (c) 2014 yczx. All rights reserved.
//

#import "LiXiWoodenWholeBodyView.h"
#define FIRSTVIEWTAG        300
#define SECONDVIEWTAG       400

@interface LiXiWoodenWholeBodyView ()
{
}
@property(nonatomic)NSInteger   num;
@property(nonatomic,strong)NSTimer  *timer;
-(IBAction)showSecondView:(id)sender;

@end
@implementation LiXiWoodenWholeBodyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)awakeFromNib
{
    UIImageView *seconView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:seconView];
    seconView.alpha = 0;
    seconView.tag = SECONDVIEWTAG;
}

-(IBAction)showSecondView:(id)sender
{
    UIView  *fristView = [self viewWithTag:FIRSTVIEWTAG];
  
    UIImageView *seconView = (UIImageView*)[self viewWithTag:SECONDVIEWTAG];
    [UIView animateWithDuration:0.7 animations:^{
        fristView.alpha = 0;
         seconView.image = [UIImage imageNamed:@"product_wholebody.png"];
        seconView.alpha = 1;
        
        
    }];
    
}

-(void)startAni
{
    // 创建
    _num = 3000;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                  target:self
                                                selector:@selector(nineImageAnimation)
                                                userInfo:nil
                                                 repeats:YES];
    
}
- (void)nineImageAnimation
{
    if (self.num == 3009) {
        [_timer invalidate];
        self.timer = nil;
        [self performSelector:@selector(nineImageViewHide) withObject:nil afterDelay:0.4];
        return;
    }
    UIImageView *imageView = (UIImageView *)[self viewWithTag:_num];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.alpha = 1;
    }];
    _num++;
}
//3008 中间imageView

-(void)nineImageViewHide
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:3009];
    UIImageView *imageView1 = (UIImageView*)[self viewWithTag:3003];
    UIImageView *imageView2 = (UIImageView*)[self viewWithTag:3007];
    UIImageView *imageView3 = (UIImageView*)[self viewWithTag:3008];
//    imageView.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView1.alpha = 0;
        imageView2.alpha = 0;
        imageView3.alpha = 0;
         imageView.alpha = 1;
        
    } completion:^(BOOL finished) {
    }];
    
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
