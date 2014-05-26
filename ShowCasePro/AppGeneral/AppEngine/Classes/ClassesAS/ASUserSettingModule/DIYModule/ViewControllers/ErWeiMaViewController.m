//
//  ErWeiMaViewController.m
//  ShowCasePro
//
//  Created by lvpw on 14-1-3.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ErWeiMaViewController.h"
#import "QRCodeGenerator.h"

@interface ErWeiMaViewController ()

@end

@implementation ErWeiMaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@", self.erweimaString);
    UIImage *image = [QRCodeGenerator qrImageForString:self.erweimaString imageSize:self.imageView.bounds.size.width withPointType:QRPointRect withPositionType:QRPositionNormal withColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    self.imageView.image = image;
    self.imageView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.imageView.layer.borderWidth = 2;
    self.imageView.layer.cornerRadius = 10;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
