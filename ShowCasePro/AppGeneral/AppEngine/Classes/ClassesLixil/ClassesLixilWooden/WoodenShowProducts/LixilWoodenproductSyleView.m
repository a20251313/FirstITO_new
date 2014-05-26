//
//  LixilWoodenproductSyleView.m
//  ShowCasePro
//
//  Created by Ran Jingfu on 5/25/14.
//  Copyright (c) 2014 yczx. All rights reserved.
//

#import "LixilWoodenproductSyleView.h"
#define BKYPRODUCTVIEWTAG   300
#define BKMPRODUCTVIEWTAG   301
#define BFGPRODUCTVIEWTAG   302
#define BKWPRODUCTVIEWTAG   303
#define OG2PRODUCTVIEWTAG   304
#define BKDPRODUCTVIEWTAG   305
#define WFFPRODUCTVIEWTAG   306
#define WFBPRODUCTVIEWTAG   307
#define WG5PRODUCTVIEWTAG   308



@interface LixilWoodenproductSyleView ()

@property(nonatomic,weak)IBOutlet   UIScrollView    *scorllView;
@end
@implementation LixilWoodenproductSyleView

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
    [_scorllView setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height*3)];
}
-(IBAction)clickProduct:(UIButton*)sender
{
    NSString    *strCode = nil;
    switch (sender.tag) {
        case BKYPRODUCTVIEWTAG:
            strCode = @"BKY";
            break;
        case BKMPRODUCTVIEWTAG:
            strCode = @"BKM";
            break;
        case BFGPRODUCTVIEWTAG:
            strCode = @"BFG";
            break;
        case BKWPRODUCTVIEWTAG:
            strCode = @"BKW";
            break;
        case OG2PRODUCTVIEWTAG:
            strCode = @"OG2";
            break;
        case BKDPRODUCTVIEWTAG:
            strCode = @"BKD";
            break;
        case WFFPRODUCTVIEWTAG:
            strCode = @"WFF";
            break;
        case WFBPRODUCTVIEWTAG:
            strCode = @"WFB";
            break;
        case WG5PRODUCTVIEWTAG:
            strCode = @"WG5";
            break;
            
        default:
            break;
    }
    
    if (_delegate && strCode && [_delegate respondsToSelector:@selector(clickWithProductCode:)])
    {
        [_delegate clickWithProductCode:strCode];
    }
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
