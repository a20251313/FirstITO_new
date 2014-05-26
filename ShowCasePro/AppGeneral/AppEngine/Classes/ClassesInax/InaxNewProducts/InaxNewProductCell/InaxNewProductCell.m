//
//  InaxNewProductCell.m
//  ShowCasePro
//
//  Created by Mac on 14-3-22.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxNewProductCell.h"

@interface InaxNewProductCell()
{
    UIImageView *imageView;
}

@end

@implementation InaxNewProductCell

-(void)showWithProduct:(InaxNewProduct *)inaxNewProduct
{
    self.inaxNewProduct = inaxNewProduct;

    NSString *imagePath = inaxNewProduct.image;
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,imagePath]];
    
    if (!image)
    {
        NSLog(@"InaxNewProductCell : 找不到图片:%@",imagePath);
        return;
    }
    
    float cellWidth = self.frame.size.width;
    
    float imageHight = (image.size.width/2) * (image.size.height/2) / cellWidth;
    
    CGRect frame = CGRectMake(0, 3, cellWidth, imageHight);
    imageView.frame = frame;
    imageView.image = image;
    
    self.frame = CGRectMake(0, 0, cellWidth, imageHight + 6);
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    //
    imageView.image = nil;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        if (!imageView)
        {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, self.frame.size.width, self.frame.size.height-6)];
            imageView.backgroundColor = [UIColor clearColor];
            imageView.image = nil;
            [self addSubview:imageView];
        }
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
