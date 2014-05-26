//
//  LixiCustomTedianView.m
//  ShowCasePro
//
//  Created by Ran Jingfu on 5/15/14.
//  Copyright (c) 2014 yczx. All rights reserved.
//

#import "LixiCustomTedianView.h"
#define COLORVIEWTAG        102
#define DoorVIEWTAG        103
#define PeijianVIEWTAG        101
@implementation LixiCustomTedianView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(IBAction)clickColor:(id)sender
{
    UIView  *imageview = [self viewWithTag:COLORVIEWTAG];
    imageview.hidden = !imageview.hidden;
    
}
-(IBAction)clickPeijian:(id)sender
{
    UIView  *imageview = [self viewWithTag:PeijianVIEWTAG];
    imageview.hidden = !imageview.hidden;
    
}
-(IBAction)clickDoorstyle:(id)sender
{
    UIView  *imageview = [self viewWithTag:DoorVIEWTAG];
    imageview.hidden = !imageview.hidden;
    
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
