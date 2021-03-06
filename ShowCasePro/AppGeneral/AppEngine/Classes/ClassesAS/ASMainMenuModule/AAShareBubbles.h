//
//  AAShareBubbles.h
//  AAShareBubbles
//
//  Created by Almas Adilbek on 26/11/13.
//  Copyright (c) 2013 Almas Adilbek. All rights reserved.
//  https://github.com/mixdesign/AAShareBubbles
//

#import <UIKit/UIKit.h>

@protocol AAShareBubblesDelegate;

typedef enum {
    
    AAMenuItemType_ProductShow = 1,
    AAMenuItemType_Colletion = 2,
    AAMenuItemType_BrandHis = 3,
    AAMenuItemType_NewProduct = 4,
    AAMenuItemType_LingGan = 5,
    AAMenuItemType_SuccessCase = 6,
    AAMenuItemType_NewTechnoledge = 7,
    AAMenuItemType_BrandVideo = 8,
    AAMenuItemType_WangDian = 9
    
} AAShareBubbleType;

@interface AAShareBubbles : UIView
{
    NSMutableArray *bubbles;
    
    // Local
    UIView *bgView;
}

@property (nonatomic, assign) id<AAShareBubblesDelegate> delegate;
//
//@property (nonatomic, assign) BOOL showFacebookBubble;
//@property (nonatomic, assign) BOOL showTwitterBubble;
//@property (nonatomic, assign) BOOL showMailBubble;
//@property (nonatomic, assign) BOOL showGooglePlusBubble;
//@property (nonatomic, assign) BOOL showTumblrBubble;

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

@protocol AAShareBubblesDelegate<NSObject>
-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType;
@end
