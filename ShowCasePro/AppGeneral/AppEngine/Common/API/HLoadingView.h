

#import <Foundation/Foundation.h>
#define AppDelegate1 ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define MainController (([AppDelegate1 window]).rootViewController)
#define MainView [MainController view]

@interface HLoadingView : UIView {

	UIView *backgroundView;
	UIImageView *imageView;
	UILabel *labelInfo;
	UIImageView *boardView;
	UIActivityIndicatorView *activityView;
}


- (void)autoHide;

- (void)setImage:(UIImage *)image;

- (void)setModelInView:(BOOL)value;

- (void)setInfo:(NSString *)info;

+ (void)showInView:(UIView *)view
             image:(UIImage *)image
              info:(NSString *)info
		  animated:(BOOL)animated
           modeled:(BOOL)modeled
          autoHide:(BOOL)autoHide;

+ (void)hideWithAnimated:(BOOL)animated;

+ (void)showImage:(UIImage *)image
             info:(NSString *)info
         autoHide:(BOOL)autoHide;

+ (void)showDefaultLoadingView;

+ (void)showLoadingViewWithMessage:(NSString *)message;

+ (void)showLoadingViewHintMessage:(NSString *)message;

+ (id)shareInstance;

@end
