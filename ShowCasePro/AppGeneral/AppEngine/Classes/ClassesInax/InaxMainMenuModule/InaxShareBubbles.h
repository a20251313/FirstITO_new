//
//  InaxShareBubbles.h
//  InaxShareBubbles
//

#import <UIKit/UIKit.h>

@protocol InaxShareBubblesDelegate;

typedef enum {
    
    InaxMenuItemType_ProductShow = 1,
    InaxMenuItemType_Colletion = 2,
    InaxMenuItemType_BrandHis = 3,
    InaxMenuItemType_NewProduct = 4,
    InaxMenuItemType_inax3DRoom = 5,
    InaxMenuItemType_SuccessCase = 6,
    InaxMenuItemType_NewTechnoledge = 7,
    InaxMenuItemType_BrandConcept = 8,
    InaxMenuItemType_WangDian = 9
    
} InaxShareBubbleType;

@interface InaxShareBubbles : UIView
{
    NSMutableArray *bubbles;
    
    // Local
    UIView *bgView;
}

@property (nonatomic, assign) id<InaxShareBubblesDelegate> delegate;

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

@protocol InaxShareBubblesDelegate<NSObject>
-(void) inaxShareBubbles:(InaxShareBubbles *)shareBubbles tappedBubbleWithType:(InaxShareBubbleType)bubbleType;
@end
