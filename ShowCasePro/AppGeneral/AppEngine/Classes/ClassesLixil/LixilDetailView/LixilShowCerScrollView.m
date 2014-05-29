//
//  LixilShowCerScrollView.m
//  ShowCasePro
//
//  Created by Joshon on 14-5-29.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilShowCerScrollView.h"

@interface LixilShowCerScrollView ()
{
    UIScrollView            *m_scrollView;
    NSArray                 *m_arrayCerNames;
    int                     m_iRowCount;
    // BOOL                    m_bIsrespondRemove;
}

@end


@implementation LixilShowCerScrollView
@synthesize arrayCerNames = m_arrayCerNames;


-(void)setArrayCerNames:(NSArray *)newarrayCerNames
{
    if (newarrayCerNames != m_arrayCerNames)
    {
        m_arrayCerNames = newarrayCerNames;
    }
    
    [self resizeAllViews];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self resizeAllViews];
}





-(void)resizeAllViews
{
    if (!m_arrayCerNames.count)
    {
        return;
    }
    
    CGFloat fwidth = self.frame.size.width;
    CGFloat fheight = self.frame.size.height;
    if (!m_scrollView)
    {
        m_scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [m_scrollView setPagingEnabled:YES];
        [m_scrollView setShowsHorizontalScrollIndicator:NO];
        [m_scrollView setShowsVerticalScrollIndicator:NO];
        [m_scrollView setBounces:NO];
        [self addSubview:m_scrollView];
    }
    [m_scrollView setFrame:CGRectMake(0, 0, fwidth, fheight)];
    
    
    int colum = m_arrayCerNames.count/m_iRowCount+(m_arrayCerNames.count%m_iRowCount?1:0);
    int imageCount = 0;
    for (UIView *view in  m_scrollView.subviews)
    {
        if (view.tag > 1000)
        {
            [view removeFromSuperview];
        }
        
    }
    for (int i = 0; i < colum; i++)
    {
        for (int j = 0; j < m_iRowCount; j++)
        {
            if (imageCount < m_arrayCerNames.count)
            {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((fwidth/m_iRowCount)*j, fheight*i, fwidth/m_iRowCount, fheight)];
                imageView.image = [UIImage imageNamed:m_arrayCerNames[imageCount]];
                [m_scrollView addSubview:imageView];
                imageView.userInteractionEnabled = YES;
                
                UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToRemove:)];
                [imageView addGestureRecognizer:tap];
                imageView.tag = 10000+i;    //just for refer
                imageCount++;
                
                if (j == m_iRowCount-1)
                {
                    NSString *strName = [NSString stringWithFormat:@"inax_lt_page4%d.png",i+1];
                    UIImage *image = [UIImage imageNamed:strName];
                    
                    if (image)
                    {
                        UIImageView *page = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.frame.size.width-image.size.width/2-30, imageView.frame.size.height-image.size.height/2-40, image.size.width/2, image.size.height/2)];
                        [imageView addSubview:page];
                        page.image = image;
                        page.tag = 10001;
                    }
                    
                }
                
            }
        }
        
    }
    
    
    [m_scrollView setContentSize:CGSizeMake(m_scrollView.frame.size.width, m_scrollView.frame.size.height*colum)];
}


-(void)clickToRemove:(id)sender
{
    self.superview.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.3 animations:^{
        [self setFrame:self.originFrame];
    } completion:^(BOOL finish){
        [self removeFromSuperview];
    }];
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_iRowCount = 2;
        // Initialization code
    }
    return self;
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
