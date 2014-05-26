//
//  SashShareBubbles.m
//  ShowCasePro
//
//  Created by Mac on 14-4-8.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#define MenuItem1_Point CGPointMake(174,265)
#define MenuItem2_Point CGPointMake(512,265)
#define MenuItem3_Point CGPointMake(850,265)
#define MenuItem4_Point CGPointMake(174,595)
#define MenuItem5_Point CGPointMake(512,595)
#define MenuItem6_Point CGPointMake(850,595)

// 动态偏移后中心位置

#define MenuItem1_OffSet_Point CGPointMake(164,255)
#define MenuItem2_OffSet_Point CGPointMake(512,255)
#define MenuItem3_OffSet_Point CGPointMake(860,255)
#define MenuItem4_OffSet_Point CGPointMake(164,605)
#define MenuItem5_OffSet_Point CGPointMake(512,605)
#define MenuItem6_OffSet_Point CGPointMake(860,605)


#import "SashShareBubbles.h"
#import <QuartzCore/QuartzCore.h>

@implementation SashShareBubbles

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

// 产品展示
-(void)productShowTapped {
    [self shareButtonTappedWithType:SashMenuItemType_ProductShow];
}

// 套件合计
-(void)collectionTapped {
    [self shareButtonTappedWithType:SashMenuItemType_Colletion];
}

// 品牌理念
-(void)brandConceptTapped {
    [self shareButtonTappedWithType:SashMenuItemType_BrandConcept];
}

// 领先技术
-(void)leadingTechTapped {
    [self shareButtonTappedWithType:SashMenuItemType_LeadingTech];
}

// 3D空间
-(void)sash3DRoomTapped {
    [self shareButtonTappedWithType:SashMenuItemType_3DRoom];
}

// 工程案例
-(void)philosophyTapped {
    [self shareButtonTappedWithType:SashMenuItemType_Philosophy];
}

-(void)shareButtonTappedWithType:(SashShareBubbleType)buttonType {
    //  [self hide];
    if([self.delegate respondsToSelector:@selector(sashShareBubbles:tappedBubbleWithType:)]) {
        [self.delegate sashShareBubbles:self tappedBubbleWithType:buttonType];
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
        
        
        UIButton *item1Bubble = [self shareButtonWithIcon:@"sash_home_showproducts" andBackgroundColorRGB:self.mailBackgroundColorRGB];
        [item1Bubble addTarget:self action:@selector(productShowTapped) forControlEvents:UIControlEventTouchUpInside];
        // [item1Bubble setFrame:MenuItem1_Frame];
        [self addSubview:item1Bubble];
        [bubbles addObject:item1Bubble];
        
        UIButton *item2Bubble = [self shareButtonWithIcon:@"sash_home_suitescollection" andBackgroundColorRGB:self.mailBackgroundColorRGB];
        [item2Bubble addTarget:self action:@selector(collectionTapped) forControlEvents:UIControlEventTouchUpInside];
        // [item2Bubble setFrame:MenuItem2_Frame];
        
        [self addSubview:item2Bubble];
        [bubbles addObject:item2Bubble];
        
        
        UIButton *item3Bubble = [self shareButtonWithIcon:@"sash_home_brandconcept1" andBackgroundColorRGB:self.mailBackgroundColorRGB];
        [item3Bubble addTarget:self action:@selector(brandConceptTapped) forControlEvents:UIControlEventTouchUpInside];
        // [item3Bubble setFrame:MenuItem3_Frame];
        [self addSubview:item3Bubble];
        [bubbles addObject:item3Bubble];
        
        UIButton *item4Bubble = [self shareButtonWithIcon:@"sash_home_leadingtech1" andBackgroundColorRGB:self.mailBackgroundColorRGB];
        [item4Bubble addTarget:self action:@selector(leadingTechTapped) forControlEvents:UIControlEventTouchUpInside];
        //  [item4Bubble setFrame:MenuItem4_Frame];
        [self addSubview:item4Bubble];
        [bubbles addObject:item4Bubble];
        
        UIButton *item5Bubble = [self shareButtonWithIcon:@"sash_home_3droom" andBackgroundColorRGB:self.mailBackgroundColorRGB];
        [item5Bubble addTarget:self action:@selector(sash3DRoomTapped) forControlEvents:UIControlEventTouchUpInside];
        // [item5Bubble setFrame:MenuItem5_Frame];
        [self addSubview:item5Bubble];
        [bubbles addObject:item5Bubble];
        
        UIButton *item6Bubble = [self shareButtonWithIcon:@"sash_home_philosophy" andBackgroundColorRGB:self.mailBackgroundColorRGB];
        [item6Bubble addTarget:self action:@selector(philosophyTapped) forControlEvents:UIControlEventTouchUpInside];
        // [item6Bubble setFrame:MenuItem6_Frame];
        [self addSubview:item6Bubble];
        [bubbles addObject:item6Bubble];
        
        
        if(bubbles.count == 0) return;
        
        NSMutableArray *coordinates = [NSMutableArray array];
        NSMutableArray *offsetnates = [NSMutableArray array];
        
        
        for (int i = 0; i < bubbles.count; ++i)
        {
            UIButton *bubble = [bubbles objectAtIndex:i];
            bubble.tag = i;
            
            CGPoint point = CGPointFromString([frameList objectAtIndex:i]);
            [coordinates addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:point.x], @"x", [NSNumber numberWithFloat:point.y], @"y", nil]];
            
            // 新增偏移后数据中心点集合
            CGPoint offsetPoint = CGPointFromString([offsetList objectAtIndex:i]);
            [offsetnates addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:offsetPoint.x], @"x", [NSNumber numberWithFloat:offsetPoint.y], @"y", nil]];
            
            
            bubble.transform = CGAffineTransformMakeScale(0.5, 0.5);
            // bubble.center = CGPointFromString([frameList objectAtIndex:i]);
            bubble.center = CGPointMake(512, 384+85);
        }
        
        
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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 330, 316);//首页模块的大小
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
