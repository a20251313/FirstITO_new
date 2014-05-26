//
//  LixilBigDetailScrollView.m
//  ShowCasePro
//
//  Created by Joshon on 14-5-14.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilBigDetailScrollView.h"

@interface LixilBigDetailScrollView ()
{
    NSArray                 *m_imageArray;
    NSInteger               m_iPage;
    UIScrollView            *m_scrollView;
    ScrollorientationType   m_iorientationType;
    UIPageControl           *m_pageControl;
    
    NSArray                 *m_arrayRbottomImages;
    
}

@property(nonatomic,strong)UIImage  *bigImage;

@end
@implementation LixilBigDetailScrollView
@synthesize imageArray = m_imageArray;
@synthesize page = m_iPage;
@synthesize orientationType = m_iorientationType;
@synthesize arrayRBottomImage = m_arrayRbottomImages;
@synthesize bigImage;


-(void)setArrayRBottomImage:(NSArray *)NewarrayRBottomImage
{
    if (m_arrayRbottomImages != NewarrayRBottomImage)
    {
        m_arrayRbottomImages = NewarrayRBottomImage;
    }
    
    [self resizeAllView];
    
}
-(void)setOrientationType:(ScrollorientationType)neworientationType
{
    m_iorientationType = neworientationType;
    [self resizeAllView];
    
}
-(void)setImageArray:(NSArray *)newimageArray
{
    if (m_imageArray != newimageArray)
    {
        m_imageArray = newimageArray;
    }
    
    [self resizeAllView];
}


-(void)setHorizontalImage:(UIImage*)image
{
    UIImageView *imageHo = (UIImageView*)[self viewWithTag:100234];
    if (!imageHo)
    {
        imageHo = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageHo.image = image;
        [self addSubview:imageHo];
        imageHo.tag = 100234;
    }
    
    [imageHo setFrame:CGRectMake((self.frame.size.width-image.size.width), (self.frame.size.height-image.size.height/2)/2, image.size.width/2, image.size.height/2)];
}

-(void)setFrame:(CGRect)newframe
{
    [super setFrame:newframe];
    [self resizeAllView];
}

-(void)setPage:(NSInteger)newpage
{
    if (newpage >= m_imageArray.count)
    {
        debugLog(@"setPage fail:%d",newpage);
        return;
    }
    m_iPage = newpage;
    [self resizeAllView];
}


-(void)clickDismiss:(id)sender
{
    if (!self.NeedDismiss)
    {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = self.origiRect;
        self.alpha = 0;
    } completion:^(BOOL finished)
     {
         [self removeFromSuperview];
         
     }];
}
-(void)resizeAllView
{
    if (!m_scrollView)
    {
        m_scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:m_scrollView];
        [m_scrollView setContentMode:UIViewContentModeScaleAspectFit];
        [m_scrollView setPagingEnabled:YES];
        m_scrollView.delegate= self;
    }
    
    
    self.userInteractionEnabled = YES;
    
    [m_scrollView setFrame:self.bounds];
    
    for (int i = 0; i < m_imageArray.count; i++)
    {
        UIImageView *imageView = (UIImageView*)[m_scrollView viewWithTag:1000+i];
        if (!imageView)
        {
            imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDismiss:)];
            [imageView addGestureRecognizer:tap];
            [m_scrollView addSubview:imageView];
            imageView.tag = 1000+i;
        }
        
        imageView.image = [m_imageArray objectAtIndex:i];
        if (m_iorientationType == ScrollorientationTypeHorizontal)
        {
            [imageView setFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        }else
        {
            [imageView setFrame:CGRectMake(0, i*self.frame.size.height, self.frame.size.width, self.frame.size.height)];
            
        }
        //右下增加指引图片
        if (m_arrayRbottomImages.count  && i < m_arrayRbottomImages.count)
        {
            UIImage     *indexImage = m_arrayRbottomImages[i];
            UIImageView *indexView = (UIImageView *)[imageView viewWithTag:2000+i];
            if (!indexView)
            {
                indexView = [[UIImageView alloc] initWithFrame:CGRectZero];
            }
            indexView.image = indexImage;
            [indexView setFrame:CGRectMake(imageView.frame.size.width-indexImage.size.width/2-20, imageView.frame.size.height-indexImage.size.height/2-20, indexImage.size.width/2, indexImage.size.height/2)];
            [imageView addSubview:indexView];
            indexView.tag = 2000+i;
            
        }
        
    }
    
   
    
    if (m_iorientationType == ScrollorientationTypeHorizontal)
    {
        [m_scrollView setContentSize:CGSizeMake(self.frame.size.width*m_imageArray.count, self.frame.size.height)];
        [m_scrollView setContentOffset:CGPointMake(self.frame.size.width*m_iPage, 0)];
    }else
    {
        [m_scrollView setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height*m_imageArray.count)];
        [m_scrollView setContentOffset:CGPointMake(0, m_iPage*self.frame.size.height)];
    }
    if (m_iorientationType == ScrollorientationTypeHorizontal)
    {
        if (!m_pageControl)
        {
            m_pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.frame.size.width-20*self.imageArray.count)/2, self.frame.size.height-40, 20*m_imageArray.count, 30)];
            [self addSubview:m_pageControl];
        }
        
        [m_pageControl setFrame:CGRectMake((self.frame.size.width-20*self.imageArray.count)/2, self.frame.size.height-40, 20*m_imageArray.count, 30)];
        m_pageControl.numberOfPages = self.imageArray.count;
        m_pageControl.currentPage = m_iPage;
    }else
    {
        m_pageControl.hidden = YES;
        m_scrollView.showsVerticalScrollIndicator = NO;
        m_scrollView.bounces = NO;
        
        
        if (self.bigImage && !m_imageArray.count)
        {
            
            UIImage *image =  self.bigImage;
            [m_scrollView setContentSize:CGSizeMake(m_scrollView.frame.size.width, image.size.height/2)];//image.size.height/2
            m_scrollView.pagingEnabled = NO;
            
            UIImageView     *firstView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_scrollView.frame.size.width, image.size.height/2)];
            [m_scrollView addSubview:firstView];
            firstView.contentMode = UIViewContentModeScaleToFill;
            firstView.tag = 1000;
            firstView.userInteractionEnabled = YES;
            firstView.image = image;
            UIImageView     *imageIndex = [[UIImageView alloc] initWithFrame:CGRectMake(m_scrollView.frame.origin.x+(m_scrollView.frame.size.width-33)/2, (m_scrollView.frame.size.height-18)-18, 33, 18)];
            imageIndex.image = [UIImage imageNamed:@"kangfeili_peijian_array.png"];
            [self addSubview:imageIndex];
        }
    }
    
  //  debugLog(@"m_scrollView contentSize:%@ user:%d \n\nsubViews:%@\n\n setContentOffset:%@",[NSValue valueWithCGSize:m_scrollView.contentSize],m_scrollView.userInteractionEnabled,m_scrollView.subviews,[NSValue valueWithCGPoint:m_scrollView.contentOffset]);
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.NeedDismiss = YES;
        // Initialization code
    }
    return self;
}


-(void)setShowBigImage:(UIImage*)image orientation:(ScrollorientationType)type
{
    if (!image)
    {
        debugLog(@"setShowBigImage return because image is nil");
        return;
    }
    
    
    for (int i = 0; i < m_imageArray.count; i++)
    {
        UIView  *view = [m_scrollView viewWithTag:1000+i];
        [view removeFromSuperview];
    }
    
    self.orientationType = type;
    
    [self setBigImage:image];
    [self resizeAllView];
    switch (type)
    {
        case ScrollorientationTypeHorizontal:
        {//reserve to future use
            /*[m_scrollView setContentSize:CGSizeMake(image.size.width/2, m_scrollView.frame.size.height)];
            UIImageView     *firstView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width/2, m_scrollView.frame.size.height)];
            [m_scrollView addSubview:firstView];
            firstView.image = image;
            UIImageView     *imageIndex = [[UIImageView alloc] initWithFrame:CGRectMake((m_scrollView.frame.size.width/2-33)-20, (m_scrollView.frame.size.height-18)/2, 33, 18)];
            imageIndex.image = [UIImage imageNamed:@"kangfeili_peijian_array.png"];
            [m_scrollView addSubview:imageIndex];*/
            
        }
    
            break;
        case ScrollorientationTypeVertical:
            
        {
            [m_scrollView setContentSize:CGSizeMake(m_scrollView.frame.size.width, image.size.height/2)];//image.size.height/2
            m_scrollView.pagingEnabled = NO;
            
            UIImageView     *firstView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_scrollView.frame.size.width, image.size.height/2)];
            [m_scrollView addSubview:firstView];
            firstView.contentMode = UIViewContentModeScaleToFill;
            firstView.tag = 1000;
            firstView.userInteractionEnabled = YES;
            firstView.image = image;
            UIImageView     *imageIndex = [[UIImageView alloc] initWithFrame:CGRectMake((m_scrollView.frame.size.width-33)/2, (m_scrollView.frame.size.height-18)-18, 33, 18)];
            imageIndex.image = [UIImage imageNamed:@"kangfeili_peijian_array.png"];
            [m_scrollView addSubview:imageIndex];
            
        }
            
            
            
            break;
            
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    
    if (m_iorientationType == ScrollorientationTypeHorizontal)
    {
        m_pageControl.currentPage = offset.x/self.frame.size.width;
    }else
    {
        m_pageControl.currentPage = offset.y/self.frame.size.height;
    }
    m_iPage = m_pageControl.currentPage;
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
