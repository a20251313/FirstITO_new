//
//  SashSuitesCollectionViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-8.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "SashSuitesCollectionViewController.h"

#define Animation_Duration 0.25

#define Collection_Cell_Identifier @"CollectionCell"

#define Collection_Cell_View_Tag    54

#define Cover_Orgin_X_1 -895
#define Cover_Orgin_X_2 -640
#define Cover_Orgin_X_3 -384
#define Cover_Orgin_X_4 -131


@interface SashSuitesCollectionViewController ()<UICollectionViewDataSource,UIScrollViewDelegate>
{
    IBOutlet UICollectionView *suiteCollectionView;
    IBOutlet UIImageView *coverView;
}

@property (nonatomic , strong) NSArray *imageNamesArray;

@property (nonatomic , strong) NSArray *orginXArray;

@end

@implementation SashSuitesCollectionViewController


#pragma mark - button event -

- (IBAction)scrollButtonEvent:(id)sender
{
    //left tag  101    right tag 102
    UIButton *button = (UIButton *)sender;
    
    int deltaScroll = 0;
    
    CGPoint scrollOffSet = suiteCollectionView.contentOffset;
    
    if (button.tag == 101)
    {
        if (scrollOffSet.x <= 0) {
            return;
        }
        
        deltaScroll = -1024;
    }
    else
    {
        if (scrollOffSet.x >= 1024*3) {
            return;
        }
        
        deltaScroll = 1024;
    }
    
    scrollOffSet.x += deltaScroll;
    
    [suiteCollectionView setContentOffset:scrollOffSet animated:YES];
    
    [self performSelector:@selector(scrollViewDidEndDecelerating:) withObject:suiteCollectionView afterDelay:0.3];
}



- (IBAction)bottomBtnPressed:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if(btn.tag == 6){
        
        [suiteCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self moveCoverToOrginX:-895];
    }
    if(btn.tag == 7){
        
        [suiteCollectionView setContentOffset:CGPointMake(1024, 0) animated:YES];
         [self moveCoverToOrginX:-640];
    }
    if(btn.tag == 8){
        
        [suiteCollectionView setContentOffset:CGPointMake(1024*2, 0) animated:YES];
         [self moveCoverToOrginX:-384];
    }
    if(btn.tag == 9){
        
        [suiteCollectionView setContentOffset:CGPointMake(1024*3, 0) animated:YES];
         [self moveCoverToOrginX:-131];
    }

    
}




#pragma mark - scroll view delegate -

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x + 512) /1024;
    
    int orginX = [((NSString *)[self.orginXArray objectAtIndex:page]) intValue];
    
    [self moveCoverToOrginX:orginX];
}


#pragma mark - collection data source -

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //4个套间
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Collection_Cell_Identifier forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:Collection_Cell_View_Tag];
    
    if (!imageView)
    {
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 543)];
        bgImageView.tag = Collection_Cell_View_Tag;
        [cell addSubview:bgImageView];
        
        imageView = bgImageView;
    }
    
    UIImage *image = [UIImage imageNamed:[self.imageNamesArray objectAtIndex:indexPath.row]];
    imageView.image = image;
    
    return cell;
}


#pragma mark - move cover-

- (void) moveCoverToOrginX:(int)orginX
{
    [UIView animateWithDuration:Animation_Duration animations:^
    {
        CGRect frame = coverView.frame;
        frame.origin.x = orginX;
        coverView.frame = frame;
    }];
}


#pragma mark - life cycle -

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
    
    [suiteCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:Collection_Cell_Identifier];
    
    
    self.imageNamesArray = [NSArray arrayWithObjects:
                            @"sash_sc_suite1.png",
                            @"sash_sc_suite2.png",
                            @"sash_sc_suite3.png",
                            @"sash_sc_suite4.png",
                            nil];
    
    self.orginXArray = @[@"-895",@"-640",@"-384",@"-131"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
