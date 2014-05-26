//
//  EcocaratShareBubbles.h
//  ShowCasePro
//
//  Created by Mac on 14-4-2.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EcocaratShareBubblesDelegate;

typedef enum {
    EcocaratMenuItemType_ProductShow = 1,
    EcocaratMenuItemType_Colletion = 2,
    EcocaratMenuItemType_BrandConcept = 3,
    EcocaratMenuItemType_NewProducts = 4,
    EcocaratMenuItemType_3DRoom = 5,
    EcocaratMenuItemType_Philosophy= 6,
    EcocaratMenuItemType_LeadingTech = 7,
    EcocaratMenuItemType_Commercials = 8,
    EcocaratMenuItemType_SalesOutlets = 9
    
} EcocaratShareBubbleType;

@interface EcocaratShareBubbles : UIView
{
    NSMutableArray *bubbles;
    
    // Local
    UIView *bgView;
}

@property (nonatomic, assign) id<EcocaratShareBubblesDelegate> delegate;

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

@protocol EcocaratShareBubblesDelegate<NSObject>
-(void) ecocaratShareBubbles:(EcocaratShareBubbles *)shareBubbles tappedBubbleWithType:(EcocaratShareBubbleType)bubbleType;
@end
