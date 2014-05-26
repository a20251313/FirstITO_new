//
//  SashShareBubbles.h
//  ShowCasePro
//
//  Created by Mac on 14-4-8.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SashShareBubblesDelegate;

typedef enum {
    SashMenuItemType_ProductShow = 1,
    SashMenuItemType_Colletion = 2,
    SashMenuItemType_BrandConcept = 3,
    SashMenuItemType_LeadingTech = 4,
    SashMenuItemType_3DRoom = 5,
    SashMenuItemType_Philosophy= 6,
} SashShareBubbleType;

@interface SashShareBubbles : UIView
{
    NSMutableArray *bubbles;
    
    // Local
    UIView *bgView;
}

@property (nonatomic, assign) id<SashShareBubblesDelegate> delegate;

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

@protocol SashShareBubblesDelegate<NSObject>
-(void) sashShareBubbles:(SashShareBubbles *)shareBubbles tappedBubbleWithType:(SashShareBubbleType)bubbleType;
@end
