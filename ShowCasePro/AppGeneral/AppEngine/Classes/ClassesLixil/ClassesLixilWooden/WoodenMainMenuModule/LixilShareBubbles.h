//
//  LixilShareBubbles.h
//  ShowCasePro
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LixilShareBubblesDelegate;

typedef enum {
    LixilMenuItemType_ProductShow = 1,
    LixilMenuItemType_Colletion = 2,
    LixilMenuItemType_FactioryIntrodution = 3,
    LixilMenuItemType_LeadingTech = 4,
    LixilMenuItemType_BrandConcept = 5,
    LixilMenuItemType_SalesOutlets= 6,
    LixilMenuItemType_3DRoom = 7,
    LixilMenuItemType_BrandHistory = 8,
    LixilMenuItemType_Philosophy = 9
    
} LixilShareBubbleType;

@interface LixilShareBubbles : UIView
{
    NSMutableArray *bubbles;
    
    // Local
    UIView *bgView;
}

@property (nonatomic, assign) id<LixilShareBubblesDelegate> delegate;

@property (nonatomic, assign) int radius;
@property (nonatomic, assign) int bubbleRadius;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, weak) UIView *parentView;

@property (nonatomic, assign) int facebookBackgroundColorRGB;
@property (nonatomic, assign) int twitterBackgroundColorRGB;
@property (nonatomic, assign) int mailBackgroundColorRGB;
@property (nonatomic, assign) int googlePlusBackgroundColorRGB;
@property (nonatomic, assign) int tumblrBackgroundColorRGB;

-(id)initWithPoint:(CGPoint)point radius:(int)radiusValue inView:(UIView *)inView;

-(void)show;
-(void)hide;

@end

@protocol LixilShareBubblesDelegate<NSObject>
-(void) lixilShareBubbles:(LixilShareBubbles *)shareBubbles tappedBubbleWithType:(LixilShareBubbleType)bubbleType;
@end