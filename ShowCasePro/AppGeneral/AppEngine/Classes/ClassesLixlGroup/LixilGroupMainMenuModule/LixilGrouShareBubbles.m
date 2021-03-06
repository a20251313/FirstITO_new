//
//  AAShareBubbles.m
//  AAShareBubbles
//
//  Created by Almas Adilbek on 26/11/13.
//  Copyright (c) 2013 Almas Adilbek. All rights reserved.
//  https://github.com/mixdesign/AAShareBubbles
//
/*
#define MenuItem1_Frame CGRectMake(40,130,310,215)
#define MenuItem2_Frame CGRectMake(350,130,310,215)
#define MenuItem3_Frame CGRectMake(670,130,310,215)
#define MenuItem4_Frame CGRectMake(40,335,310,215)
#define MenuItem5_Frame CGRectMake(350,335,310,215)
#define MenuItem6_Frame CGRectMake(670,335,310,215)
#define MenuItem7_Frame CGRectMake(40,540,310,215)
#define MenuItem8_Frame CGRectMake(350,540,310,215)
#define MenuItem9_Frame CGRectMake(670,540,310,215)
*/

#define MenuItem1_Point CGPointMake(174,184+85)
#define MenuItem2_Point CGPointMake(511,184+85)
#define MenuItem3_Point CGPointMake(850,184+85)
#define MenuItem4_Point CGPointMake(174,514+85)
#define MenuItem5_Point CGPointMake(511,514+85)
#define MenuItem6_Point CGPointMake(850,514+85)

// 动态偏移后中心位置

#define MenuItem1_OffSet_Point CGPointMake(164,174+85)
#define MenuItem2_OffSet_Point CGPointMake(511,174+85)
#define MenuItem3_OffSet_Point CGPointMake(860,174+85)
#define MenuItem4_OffSet_Point CGPointMake(164,524+85)
#define MenuItem5_OffSet_Point CGPointMake(511,524+85)
#define MenuItem6_OffSet_Point CGPointMake(860,524+85)


#import "LixilGrouShareBubbles.h"
#import <QuartzCore/QuartzCore.h>

@interface LixilGrouShareBubbles()
@end

@implementation LixilGrouShareBubbles

@synthesize delegate = _delegate, parentView;

- (id)initWithPoint:(CGPoint)point radius:(int)radiusValue inView:(UIView *)inView
{
    self = [super initWithFrame:CGRectMake(0, 0, 1024, 768)];
    if (self) {
        self.parentView = inView;
        
        self.facebookBackgroundColorRGB = 0x3c5a9a;
        self.twitterBackgroundColorRGB = 0x3083be;
        self.mailBackgroundColorRGB = 0xbb54b5;
        self.googlePlusBackgroundColorRGB = 0xd95433;
        self.tumblrBackgroundColorRGB = 0x385877;
    }
    return self;
}

#pragma mark -
#pragma mark Actions
// 集团介绍
-(void)GroupIntraduceTapped {
    [self shareButtonTappedWithType:AAMenuItemType_GroupIntraduce];
}

// 企业理念
-(void)QiYelinianTapped {
    [self shareButtonTappedWithType:AAMenuItemType_QiYelinian];
}

// 一站式服务
-(void)ServiceTapped {
    [self shareButtonTappedWithType:AAMenuItemType_Service];
}

// 集团历史
-(void)GroupHisTapped {
    [self shareButtonTappedWithType:AAMenuItemType_GroupHis];
}

// 集团视频
-(void)GroupVideoTapped {
    [self shareButtonTappedWithType:AAMenuItemType_GroupVideo];
}

// 企业网点
-(void)GroupWandianTapped {
    [self shareButtonTappedWithType:AAMenuItemType_GroupWandian];
}


-(void)shareButtonTappedWithType:(LixilGrouShareBubbleType)buttonType {
  //  [self hide];
    if([self.delegate respondsToSelector:@selector(aaShareBubbles:tappedBubbleWithType:)]) {
        [self.delegate aaShareBubbles:self tappedBubbleWithType:buttonType];
    }
}

#pragma mark -
#pragma mark Methods

-(void)show
{
    if(!self.isAnimating)
    {
        self.isAnimating = YES;
        
        [self.parentView addSubview:self];
        
        // Create background
        bgView = [[UIView alloc] initWithFrame:self.parentView.bounds];
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewBackgroundTapped:)];
        [bgView addGestureRecognizer:tapges];
        [parentView addSubview:bgView];
        [parentView insertSubview:bgView belowSubview:self];
        // --
        
        if(bubbles) {
            bubbles = nil;
        }
        bubbles = [[NSMutableArray alloc] init];
        
        NSMutableArray *frameList = [NSMutableArray array];
        
        NSMutableArray *offsetList = [NSMutableArray array];
    
       
        [frameList addObject:NSStringFromCGPoint(MenuItem1_Point)];
        [frameList addObject:NSStringFromCGPoint(MenuItem2_Point)];
        [frameList addObject:NSStringFromCGPoint(MenuItem3_Point)];
        [frameList addObject:NSStringFromCGPoint(MenuItem4_Point)];
        [frameList addObject:NSStringFromCGPoint(MenuItem5_Point)];
        [frameList addObject:NSStringFromCGPoint(MenuItem6_Point)];
        
        [offsetList addObject:NSStringFromCGPoint(MenuItem1_OffSet_Point)];
        [offsetList addObject:NSStringFromCGPoint(MenuItem2_OffSet_Point)];
        [offsetList addObject:NSStringFromCGPoint(MenuItem3_OffSet_Point)];
        [offsetList addObject:NSStringFromCGPoint(MenuItem4_OffSet_Point)];
        [offsetList addObject:NSStringFromCGPoint(MenuItem5_OffSet_Point)];
        [offsetList addObject:NSStringFromCGPoint(MenuItem6_OffSet_Point)];
        
        
        UIButton *item1Bubble = [self shareButtonWithIcon:@"lixil_menu_groupIntroduce" andBackgroundColorRGB:self.mailBackgroundColorRGB];
        [item1Bubble addTarget:self action:@selector(GroupIntraduceTapped) forControlEvents:UIControlEventTouchUpInside];
       // [item1Bubble setFrame:MenuItem1_Frame];
        [self addSubview:item1Bubble];
        [bubbles addObject:item1Bubble];
        
        UIButton *item2Bubble = [self shareButtonWithIcon:@"lixil_menu_group_Linian" andBackgroundColorRGB:self.mailBackgroundColorRGB];
        [item2Bubble addTarget:self action:@selector(QiYelinianTapped) forControlEvents:UIControlEventTouchUpInside];
       // [item2Bubble setFrame:MenuItem2_Frame];
        
        [self addSubview:item2Bubble];
        [bubbles addObject:item2Bubble];
        
        
        UIButton *item3Bubble = [self shareButtonWithIcon:@"lixil_menu_Service" andBackgroundColorRGB:self.mailBackgroundColorRGB];
        [item3Bubble addTarget:self action:@selector(ServiceTapped) forControlEvents:UIControlEventTouchUpInside];
       // [item3Bubble setFrame:MenuItem3_Frame];
        [self addSubview:item3Bubble];
        [bubbles addObject:item3Bubble];
        
        UIButton *item4Bubble = [self shareButtonWithIcon:@"lixil_menu_history" andBackgroundColorRGB:self.mailBackgroundColorRGB];
        [item4Bubble addTarget:self action:@selector(GroupHisTapped) forControlEvents:UIControlEventTouchUpInside];
      //  [item4Bubble setFrame:MenuItem4_Frame];
        [self addSubview:item4Bubble];
        [bubbles addObject:item4Bubble];
        
        UIButton *item5Bubble = [self shareButtonWithIcon:@"lixil_menu_groupVideo" andBackgroundColorRGB:self.mailBackgroundColorRGB];
        [item5Bubble addTarget:self action:@selector(GroupVideoTapped) forControlEvents:UIControlEventTouchUpInside];
       // [item5Bubble setFrame:MenuItem5_Frame];
        [self addSubview:item5Bubble];
        [bubbles addObject:item5Bubble];
        
        UIButton *item6Bubble = [self shareButtonWithIcon:@"lixil_menu_groupWangdian" andBackgroundColorRGB:self.mailBackgroundColorRGB];
        [item6Bubble addTarget:self action:@selector(GroupWandianTapped) forControlEvents:UIControlEventTouchUpInside];
       // [item6Bubble setFrame:MenuItem6_Frame];
        [self addSubview:item6Bubble];
        [bubbles addObject:item6Bubble];
        
        
        if(bubbles.count == 0) return;
        
//        float bubbleDistanceFromPivot = self.radius - self.bubbleRadius;
//        
//        float bubblesBetweenAngel = 360 / bubbles.count;
//        float angely = (180 - bubblesBetweenAngel) * 0.5;
//        float startAngel = 180 - angely;
        
        NSMutableArray *coordinates = [NSMutableArray array];
        NSMutableArray *offsetnates = [NSMutableArray array];
        
        
        for (int i = 0; i < bubbles.count; ++i)
        {
            UIButton *bubble = [bubbles objectAtIndex:i];
            bubble.tag = i;
            
//            float angle = startAngel + i * bubblesBetweenAngel;
//            float x = cos(angle * M_PI / 180) * bubbleDistanceFromPivot + self.radius;
//            float y = sin(angle * M_PI / 180) * bubbleDistanceFromPivot + self.radius;
//
            CGPoint point = CGPointFromString([frameList objectAtIndex:i]);
            [coordinates addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:point.x], @"x", [NSNumber numberWithFloat:point.y], @"y", nil]];
            
            // 新增偏移后数据中心点集合
            CGPoint offsetPoint = CGPointFromString([offsetList objectAtIndex:i]);
            [offsetnates addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:offsetPoint.x], @"x", [NSNumber numberWithFloat:offsetPoint.y], @"y", nil]];
            
            
            bubble.transform = CGAffineTransformMakeScale(0.5, 0.5);
           // bubble.center = CGPointFromString([frameList objectAtIndex:i]);
            bubble.center = CGPointMake(512, 384);
        }
        
        /* 屏蔽瞬时加载功能
        int inetratorI = 0;
        for (NSDictionary *coordinate in coordinates)
        {
            UIButton *bubble = [bubbles objectAtIndex:inetratorI];
            float delayTime = inetratorI * 0.1;
            [self performSelector:@selector(showBubbleWithAnimation:) withObject:[NSDictionary dictionaryWithObjectsAndKeys:bubble, @"button", coordinate, @"coordinate", nil] afterDelay:delayTime];
            ++inetratorI;
        }
        */
        
        // 修改为全部加载
        int inetratorI = 0;
        for (NSDictionary *coordinate in coordinates)
        {
            UIButton *bubble = [bubbles objectAtIndex:inetratorI];
            
           int index = [coordinates indexOfObject:coordinate];
            
            [self showBubbleWithAnimation:[NSDictionary dictionaryWithObjectsAndKeys:bubble, @"button", coordinate, @"coordinate",[offsetnates objectAtIndex:index],@"offsetnate", nil]];
            
            ++inetratorI;
        }
        
    }
}
-(void)hide
{
    if(!self.isAnimating)
    {
        self.isAnimating = YES;
        int inetratorI = 0;
        for (UIButton *bubble in bubbles)
        {
            float delayTime = inetratorI * 0.1;
            [self performSelector:@selector(hideBubbleWithAnimation:) withObject:bubble afterDelay:delayTime];
            ++inetratorI;
        }
    }
}

#pragma mark -
#pragma mark Helper functions

-(void)shareViewBackgroundTapped:(UITapGestureRecognizer *)tapGesture {
    [tapGesture.view removeFromSuperview];
   // [self hide];
}

-(void)showBubbleWithAnimation:(NSDictionary *)info
{
    UIButton *bubble = (UIButton *)[info objectForKey:@"button"];
    NSDictionary *coordinate = (NSDictionary *)[info objectForKey:@"coordinate"];
    NSDictionary *offsetDict = (NSDictionary *)[info objectForKey:@"offsetnate"];
   /* 屏蔽抖动效果
    [UIView animateWithDuration:0.25 animations:^{
        bubble.center = CGPointMake([[coordinate objectForKey:@"x"] floatValue], [[coordinate objectForKey:@"y"] floatValue]);
        bubble.alpha = 1;
        bubble.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            bubble.transform = CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                bubble.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                if(bubble.tag == bubbles.count - 1) self.isAnimating = NO;
                bubble.layer.shadowColor = [UIColor blackColor].CGColor;
                bubble.layer.shadowOpacity = 0.2;
                bubble.layer.shadowOffset = CGSizeMake(0, 1);
                bubble.layer.shadowRadius = 2;
            }];
        }];
    }];
    
    */

    
    [UIView animateWithDuration:0.3f animations:^{
        bubble.center = CGPointMake([[coordinate objectForKey:@"x"] floatValue], [[coordinate objectForKey:@"y"] floatValue]);
        bubble.alpha = 1;
        bubble.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.001f animations:^{
        
            bubble.center = CGPointMake([[offsetDict objectForKey:@"x"] floatValue], [[offsetDict objectForKey:@"y"] floatValue]);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.3f animations:^{
                
                bubble.center = CGPointMake([[coordinate objectForKey:@"x"] floatValue], [[coordinate objectForKey:@"y"] floatValue]);
                
            } completion:^(BOOL finished) {
                
                if(bubble.tag == bubbles.count - 1) self.isAnimating = NO;
                bubble.layer.shadowColor = [UIColor blackColor].CGColor;
                bubble.layer.shadowOpacity = 0.2;
                bubble.layer.shadowOffset = CGSizeMake(0, 1);
                bubble.layer.shadowRadius = 2;
            }];
        }];
    }];
}

-(void)hideBubbleWithAnimation:(UIButton *)bubble
{
    [UIView animateWithDuration:0.2 animations:^{
        bubble.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            bubble.center = CGPointMake(self.radius, self.radius);
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.alpha = 0;
        } completion:^(BOOL finished) {
            if(bubble.tag == bubbles.count - 1) {
                self.isAnimating = NO;
                self.hidden = YES;
                [bgView removeFromSuperview];
                bgView = nil;
                [self removeFromSuperview];
            }
            [bubble removeFromSuperview];
        }];
    }];
}


-(UIButton *)shareButtonWithIcon:(NSString *)iconName andBackgroundColorRGB:(int)rgb
{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 0, 310, 215);
//    
//    // Circle background
//    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 215)];
//    circle.backgroundColor = [self colorFromRGB:rgb];
//    //circle.layer.cornerRadius = self.bubbleRadius;
//    //circle.layer.masksToBounds = YES;
//    circle.opaque = NO;
//    circle.alpha = 0.97;
//    
//    // Circle icon
//    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
//    CGRect f = icon.frame;
//    f.origin.x = (circle.frame.size.width - f.size.width) * 0.5;
//    f.origin.y = (circle.frame.size.height - f.size.height) * 0.5;
//    icon.frame = f;
//    [circle addSubview:icon];
//    
//    [button setBackgroundImage:[self imageWithView:circle] forState:UIControlStateNormal];
//    
//    return button;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 330, 319);
    button.adjustsImageWhenHighlighted = NO;
    
//    // Circle background
//    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 215)];
//    circle.backgroundColor = [self colorFromRGB:rgb];
//    //circle.layer.cornerRadius = self.bubbleRadius;
//    //circle.layer.masksToBounds = YES;
//    circle.opaque = NO;
//    circle.alpha = 0.97;
//    
//    // Circle icon
//    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
//    CGRect f = icon.frame;
//    f.origin.x = (circle.frame.size.width - f.size.width) * 0.5;
//    f.origin.y = (circle.frame.size.height - f.size.height) * 0.5;
//    icon.frame = f;
//    [circle addSubview:icon];
    
    [button setBackgroundImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    
    return button;
    
}

-(UIColor *)colorFromRGB:(int)rgb {
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0];
}

-(UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
