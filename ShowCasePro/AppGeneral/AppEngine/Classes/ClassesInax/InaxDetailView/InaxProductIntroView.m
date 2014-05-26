//
//  InaxProductIntroView.m
//  InaxProductDetailView
//
//  Created by CY-003 on 13-11-12.
//  Copyright (c) 2013年 CY-003. All rights reserved.
//

#import "InaxProductIntroView.h"
#import "DatabaseOption+condition.h"
#import "MacroDefine.h"
#import "LibraryAPI.h"

@implementation InaxProductIntroView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.8)];
        productImageView.image = nil;
        productImageView.contentMode = UIViewContentModeScaleAspectFit;//
        productImageView.backgroundColor = [UIColor whiteColor];
        productImageView.userInteractionEnabled = YES;
        [self addSubview:productImageView];
        
        textView = [[UIView alloc] initWithFrame:CGRectMake(0, productImageView.frame.size.height, self.frame.size.width, self.frame.size.height * 0.2)];
        textView.backgroundColor = [UIColor grayColor];
        [self addSubview:textView];
        
        nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, textView.frame.size.height / 2)];
        nameLable.font = [UIFont systemFontOfSize:15];
        nameLable.text = @"";
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.adjustsFontSizeToFitWidth = NO;
        nameLable.contentMode = UIViewContentModeScaleAspectFill;
        nameLable.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [textView addSubview:nameLable];
        
        modelLable = [[UILabel alloc] initWithFrame:CGRectMake(0, textView.frame.size.height / 2, self.frame.size.width, textView.frame.size.height / 2)];
        modelLable.font = [UIFont systemFontOfSize:14];
        modelLable.text = @"";
        modelLable.textAlignment = NSTextAlignmentCenter;
        modelLable.adjustsFontSizeToFitWidth = NO;
        modelLable.contentMode = UIViewContentModeScaleAspectFill;
        modelLable.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [textView addSubview:modelLable];
        
        //        modelLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, textView.frame.size.height)];
        //        modelLable.text = @"";
        //        modelLable.textAlignment = NSTextAlignmentCenter;
        //        modelLable.adjustsFontSizeToFitWidth = NO;
        //        modelLable.contentMode = UIViewContentModeScaleAspectFill;
        //        [textView addSubview:modelLable];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(pushToProductDetailView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        nameLable.backgroundColor = [UIColor clearColor];
        modelLable.backgroundColor = [UIColor clearColor];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return self;
}

- (void) pushToProductDetailView
{
    //NSLog(@"pushToProductDetailView %@",self.productid);
    
    [self.delegate didSelectProductIntroView:self];
}


- (UIImage*)getProductImage
{
    return productImageView.image;
}


-(void)reloadData
{
    if (!self.tProduct)
    {
        if (!self.productid || [self.productid isEqualToString:@""])
        {
            return;
        }
        
        self.tProduct = [[[DatabaseOption alloc] init] tProductByProductID:self.productid];
        
        if (!self.tProduct)
        {
            return;
        }
    }
    
    nameLable.text          = [self deleteSpaceString:self.tProduct.name];
    modelLable.text         = [self deleteSpaceString:self.tProduct.code];
    
    //modelLable.text         = [self deleteSpaceString:self.tProduct.code];
    
    
    // scale image in background
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kDocuments,self.tProduct.image1]];
        //        UIImage *endImage = [UIImage scaleImage:image toSize:CGSizeMake(image.size.width/4, image.size.height/4)];
        UIImage *endImage = [[LibraryAPI sharedInstance] getImageFromPath:self.tProduct.image1 scale:4];
        dispatch_async(dispatch_get_main_queue(), ^{
            productImageView.image = endImage;
        });
    });
    
    
    //    productImageView.image  = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kDocuments,self.tProduct.image1]];
    
}

-(void)layoutSubviews
{
    [UIView animateWithDuration:0.3 animations:^
     {
         productImageView.frame  = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.8);
         textView.frame          = CGRectMake(0, productImageView.frame.size.height, self.frame.size.width, self.frame.size.height * 0.2);
         nameLable.frame         = CGRectMake(0, 0, self.frame.size.width, textView.frame.size.height / 2);
         modelLable.frame        = CGRectMake(0, textView.frame.size.height / 2, self.frame.size.width, textView.frame.size.height / 2);
         //modelLable.frame        = CGRectMake(0, 0, self.frame.size.width, textView.frame.size.height);
         button.frame            = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
     }];
}

- (NSString *) deleteSpaceString:(NSString *)string
{
    if (!string || !string.length) {
        return nil;
    }
    
    while (1)
    {
        if (!string.length) {
            break;
        }
        
        if ([[string substringWithRange:NSMakeRange(string.length-1,1)] isEqualToString:@" "])
        {
            string = [string substringWithRange:NSMakeRange(0, string.length-1)];
        }
        else
        {
            break;
        }
    }
    
    return string;
}

@end
