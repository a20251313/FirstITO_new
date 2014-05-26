//
//  AAShareBubbles.h
//  AAShareBubbles
//
//  Created by Almas Adilbek on 26/11/13.
//  Copyright (c) 2013 Almas Adilbek. All rights reserved.
//  https://github.com/mixdesign/AAShareBubbles
//

#import <UIKit/UIKit.h>

@protocol LixilGrouShareBubblesDelegate;

typedef enum {
    
    AAMenuItemType_GroupIntraduce = 1,
    AAMenuItemType_QiYelinian = 2,
    AAMenuItemType_Service = 3,
    AAMenuItemType_GroupHis = 4,
    AAMenuItemType_GroupVideo = 5,
    AAMenuItemType_GroupWandian = 6
    
} LixilGrouShareBubbleType;

@interface LixilGrouShareBubbles : UIView
{
    NSMutableArray *bubbles;
    
    // Local
    UIView *bgView;
}

@property (nonatomic, assign) id<LixilGrouShareBubblesDelegate> delegate;
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

@protocol LixilGrouShareBubblesDelegate<NSObject>
-(void)aaShareBubbles:(LixilGrouShareBubbles *)shareBubbles tappedBubbleWithType:(LixilGrouShareBubbleType)bubbleType;
@end
