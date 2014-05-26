//
//  ASNewProductVC.m
//  ShowCasePro
//
//  Created by yczx on 14-2-26.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#define AnimationDuration     1.0f

#import "ASNewProductVC.h"
#import "GenericDao.h"
#import "TNewProduct.h"
#import "BrandSpaceButton.h"


@interface ASNewProductVC ()
{
    BOOL alreadTap;
}


@property (nonatomic,strong) NSMutableArray *porDataList;

@property(nonatomic,assign) CGPoint moveCenterPoint;

@end


@implementation ASNewProductVC

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

    alreadTap =  NO;
    // Do any additional setup after loading the view from its nib.
    
    _itemList = [NSMutableArray array];
    
//    [self.itemContentView setCenter:CGPointMake(self.asnewProdDescView.frame.size.width/2 , self.asnewProdDescView.frame.size.height / 2 + 100)];
//
    
    
    [self.itemContentView setFrame:CGRectMake(0, 0, self.itemContentView.image.size.width / 2, self.itemContentView.image.size.height / 2)];
    //;(self.asnewProdDescView.frame.size.width/2 , self.asnewProdDescView.frame.size.height / 2 + 100)];
    
    
    
    [self.asnewProdDescView addSubview:self.itemContentView];
    
    [self.asnewProdDescView setAlpha:0];
    self.aspageControl.numberOfPages = 2;
    
    
    [self.view addSubview:_itemBgView];
    
    [_itemBgView setFrame:CGRectMake(0, 176, _itemBgView.frame.size.width, _itemBgView.frame.size.height)];
    
    [_itemBgView setAlpha:0];
    
    
    [self.view bringSubviewToFront:_asnewProdDescView];
    
    // 加载数据到 滚动视图
   [self loadNewProductDataToScrollView];
    
    // 添加触摸事件
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundTouched:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [self.asnewProScrollView addGestureRecognizer:tap];
    
  
}

//
//// 加载数据到 滚动视图
-(void)loadNewProductDataToScrollView
{
    NSString *localDataPath  = [[NSBundle mainBundle] pathForResource:@"NewProductOnline" ofType:@"plist"];
    
    _productLocalDict = [[NSMutableDictionary alloc] initWithContentsOfFile:localDataPath];
    
    GenericDao *jd = [[GenericDao alloc] initWithClassName:@"TNewProduct"];
    NSString * sql = [NSString stringWithFormat:@"select * from tnewproduct where brandid = %@",[[LibraryAPI sharedInstance] currentBrandID]] ;
    
    _porDataList = [jd selectObjectsByStrSQL:sql options:@{@"newproductID":@"id",@"proTypeid":@"typeid"} ];
    
    
    //NSArray *itemList = [_productLocalDict objectForKey:@"NewProductList"];
    
    for (int i=0; i<_porDataList.count; i++) {
        
        TNewProduct *itemDict = (TNewProduct *)[_porDataList objectAtIndex:i];
        
      //  NSString *itemID = itemDict.newproductID;
        NSString *itemImage = itemDict.image; //[itemDict objectForKey:@"itemImage"];
        
        CGFloat pos_X = [itemDict.posx floatValue];
        CGFloat pos_Y = [itemDict.posy floatValue];
        
        CGPoint itemPosition = CGPointMake(pos_X, pos_Y);
        
        BrandSpaceButton *btn = [BrandSpaceButton buttonWithType:UIButtonTypeCustom];
        
        NSString *path = [NSString stringWithFormat:@"%@/%@",kLibrary,itemImage];
        
        [btn setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        
        [btn setFrame:CGRectMake(0, 0, 153, 304)];
        
        [btn setCenter:itemPosition];
        
        [btn setItemTag:i];
        
        [btn setBrandSpaceDict:[NSDictionary dictionaryWithObjectsAndKeys:itemDict.suiteid,@"suiteid",itemDict.proTypeid,@"typeid", nil]];
        
        [btn addTarget:self action:@selector(scrollViewItemBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        [_asnewProScrollView addSubview:btn];
        
        [_itemList addObject:btn];
        
    }
    
    int pageNum = [self getContentPagesByList:_porDataList withItemofPage:6];
    
    [self.asnewProScrollView setContentSize:CGSizeMake(1024 * pageNum, _asnewProScrollView.frame.size.height)];
    
    [self.view bringSubviewToFront:_asnewProScrollView];
    
}


// 返回当前内容需要的页码
-(int)getContentPagesByList:(NSArray *)data withItemofPage:(int) num
{
    int page = 0;
    
    page = (data.count % num);
    
    if (page == 0)
    {
        page = data.count / num;
    } else {
        page = data.count / num;
        page++;
    }
    
    return page;
}


// item点击事件
-(void)scrollViewItemBtnEvent:(BrandSpaceButton *)sender
{
 
    if (alreadTap) return;
   
    alreadTap = YES;
    _asnewProScrollView.userInteractionEnabled = NO;
    
    BrandSpaceButton *selBtn = sender;
    
    self.befortMovePoint = selBtn.center;
    
   // [self.itemContentView setCenter:CGPointMake(selBtn.center.x + self.itemContentView.frame.size.width / 2 + 50, self.itemContentView.center.y)];
    // 加载 新品描述图片
    
    TNewProduct *itemDict = (TNewProduct *)[_porDataList objectAtIndex:sender.itemTag];
   
    NSString *path = [NSString stringWithFormat:@"%@/%@",kLibrary,itemDict.imagedes];
    
    UIImage * desImag = [UIImage imageWithContentsOfFile:path];
    UIImageView *DesImageView = [[UIImageView alloc] initWithImage:desImag];
    [DesImageView setFrame:CGRectMake(0, 0, desImag.size.width / 2, desImag.size.height / 2)];
    
    for (NSObject *obj in _asnewProdDescView.subviews) {
        UIImageView *image = (UIImageView *)obj;
        [image removeFromSuperview];
    }
    
   
    // 取模计算出文字显示部分应该在当前点击视图的 左边还是右

    int starX = selBtn.center.x;
    
    starX = (starX % 1024);
    
    if (starX < 1024/2) {
        
        [self.asnewProdDescView setCenter:CGPointMake(268 + _asnewProdDescView.frame.size.width/2 + 70, 768 / 2 +  selBtn.frame.size.height/2)];
    } else
    {
        [self.asnewProdDescView setCenter:CGPointMake(748 - _asnewProdDescView.frame.size.width/2 - 60, 768 / 2 +  selBtn.frame.size.height/2)];
    }

    
    // 执行动画效果
    
    [UIView animateWithDuration:AnimationDuration animations:^{
        
        [selBtn setCenter:CGPointMake(selBtn.center.x, 176 + selBtn.frame.size.height/2)];
        
        [self.asnewProTitleImage setCenter:CGPointMake(1024/2, 80)];
        
      //  [self.asnewProdDescView setCenter:CGPointMake(self.asnewProdDescView.center.x,176 + selBtn.frame.size.height/2)];
       
        
        [self.itemBgView setAlpha:1];
        
        // 隐藏其他的Item
        for (NSObject *obj in self.asnewProScrollView.subviews) {
            
            if ([obj isKindOfClass:[BrandSpaceButton class]]){
                
                BrandSpaceButton *btn = (BrandSpaceButton *)obj;
                
                if (btn.itemTag != selBtn.itemTag)
                {
                    [btn setAlpha:0];
                }
                
            }
        }
        
    } completion:^(BOOL finished) {
        
        self.moveCenterPoint = selBtn.center;
        
        CGFloat moveDistince = [self getItemMovePostionX:selBtn];
        [self.asnewProdDescView addSubview:DesImageView];
        //[self.asnewProdDescView addSubview:_itemContentView];
        [DesImageView setCenter:CGPointMake(_asnewProdDescView.frame.size.width / 2, _asnewProdDescView.frame.size.height / 2)];
        
        
        [self.asnewProdDescView setAlpha:0];
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            
            [self.asnewProdDescView setAlpha:1];
            
            [selBtn setCenter:CGPointMake(selBtn.center.x + moveDistince, selBtn.center.y)];
            
            [self.asnewProdDescView setCenter:CGPointMake(self.asnewProdDescView.center.x,176 + selBtn.frame.size.height/2)];
            
        } completion:^(BOOL finished) {
            
            
            
            // 禁用掉滚动方法
            [_asnewProScrollView setScrollEnabled:NO];
            
            self.currSelBtn = selBtn;
            
            _asnewProScrollView.userInteractionEnabled = YES;
            
        }];

    }];
    
}

// 判断当前点击的对象的运动方向
-(CGFloat)getItemMovePostionX:(UIButton *)btn
{
    CGFloat ret = 0;
    
    CGFloat distance1 = 268;
    CGFloat distance2 = 748;
    
    int starX = btn.center.x;
    
  //  CGFloat modX = (starX % 1024);
    
    if (starX < 1024)
    {
       
        if ((starX < 1024/2) && (starX > distance1)) {
            
            ret = -(btn.center.x - distance1);
        }else if ((starX < 1024/2) && (starX < distance1)){
            ret = distance1 - btn.center.x;
        }else if ((starX > 1024/2) && (starX < distance2)){
            ret = distance2 - btn.center.x;
        }else if ((starX > 1024/2) && (starX > distance2)){
            ret =  - (btn.center.x - distance2);
        }
        
    } else
    {
        distance1+=1024;
        distance2+=1024;
        
        if ((starX < 1536) && (starX > distance1))
        {
            ret = -(btn.center.x - distance1);
        }
        else if ((starX < 1536) && (starX < distance1))
        {
            ret = distance1 - btn.center.x;
        }else if ((starX > 1536) && (starX < distance2))
        {
            ret = distance2 - btn.center.x;
        }else if ((starX > 1536) && (starX > distance2))
        {
            ret =  - (btn.center.x - distance2);
        }
    }
    

    
    
    return ret;
}


// 触摸点击事件
-(void)backGroundTouched:(UITapGestureRecognizer *)sender
{
    
    [UIView animateWithDuration:AnimationDuration animations:^{
        
         [self.currSelBtn setCenter:self.moveCenterPoint];
        
    } completion:^(BOOL finished) {
        
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            
            [self.currSelBtn setCenter:self.befortMovePoint];
            
            [self.asnewProTitleImage setCenter:CGPointMake(1024/2, 140)];
            
            [self.asnewProdDescView setCenter:CGPointMake(self.asnewProdDescView.center.x, 768 / 2 +  _currSelBtn.frame.size.height/2)];
            
            [self.asnewProdDescView setAlpha:0];
            [self.itemBgView setAlpha:0];
            
            
            // 显示其他的Item
            for (NSObject *obj in self.asnewProScrollView.subviews) {
                
                if ([obj isKindOfClass:[UIButton class]]){
                    
                    BrandSpaceButton *btn = (BrandSpaceButton *)obj;
                    
                    if (btn.itemTag != _currSelBtn.itemTag)
                    {
                        [btn setAlpha:1];
                    }
                    
                }
            }
            
            
        } completion:^(BOOL finished) {
            
            // 开启滚动方法
            [_asnewProScrollView setScrollEnabled:YES];
            
            self.currSelBtn = nil;
            
            alreadTap = NO;
        }];
        
        
    }];
    

}


#pragma mark --UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    int page = _asnewProScrollView.contentOffset.x / 1024;//通过滚动的偏移量来判断目前页面所对应的小白点
    
    _aspageControl.currentPage = page;//pagecontroll响应值的变化
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
