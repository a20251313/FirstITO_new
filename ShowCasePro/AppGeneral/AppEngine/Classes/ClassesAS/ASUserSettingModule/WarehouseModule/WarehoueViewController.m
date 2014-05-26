//
//  WarehoueViewController.m
//  ShowCasePro
//
//  Created by yczx on 13-11-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "WarehoueViewController.h"

#import <MAMapKit/MAMapKit.h>
#import "LHDropDownControlView.h"
#import "CusMAPinAnnotationView.h"
#import "Store.h"
#import "OfflineDetailViewController.h"
#import "ScreenshotViewController.h"
#import "LibraryAPI.h"

#define kCalloutViewMargin          -8

@interface WarehoueViewController () <LHDropDownControlViewDelegate, MAMapViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UILabel *currentBrandLabel;
@property (nonatomic, weak) UIButton *currentBtn;
@property (nonatomic, strong) UIButton *provinceBtn;
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, copy) NSArray *provinces;
@property (nonatomic, copy) NSArray *cities;
@property (nonatomic, copy) NSDictionary *provincesAndCities;
@property (nonatomic, strong) NSString *currentProvince;
@property (nonatomic, strong) NSString *currentCity;
//@property (nonatomic, strong) LHDropDownControlView *provinceDropDownController;
@property (nonatomic, strong) LHDropDownControlView *cityDropDownController;
@property (nonatomic, strong) NSMutableArray *annotations;
@property (nonatomic, strong) NSMutableArray *stores;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *container2;
@property (nonatomic, strong) UIView *paddingView;

@end

@implementation WarehoueViewController

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.stores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *storeCell = @"storeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:storeCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:storeCell];
    }
    //    NSDictionary *store = [self.stores objectAtIndex:[indexPath row]];
    Store *store = [self.stores objectAtIndex:[indexPath row]];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = store.stroreName;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = store.storeAddress;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 在地图上选择点击的地点
    [self.mapView selectAnnotation:[self.annotations objectAtIndex:[indexPath row]] animated:YES];
    
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        CusMAPinAnnotationView *annotationView = (CusMAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[CusMAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            annotationView.mapView = mapView;
            // 设置calloutView显示内容
            NSInteger index = [self.annotations indexOfObject:annotation];
            annotationView.store = [self.stores objectAtIndex:index];
            // 设置为NO 目的是弹出自定义的calloutView
            annotationView.canShowCallout = NO;
            annotationView.animatesDrop = YES;
            annotationView.draggable = YES;
        }
        annotationView.pinColor = [self.annotations indexOfObject:annotation];
        return annotationView;
    }
    return nil;
}
// 重新调整mapView 来显示calloutView
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    /* Adjust the map center in order to show the callout view completely. */
    if ([view isKindOfClass:[CusMAPinAnnotationView class]]) {
        CusMAPinAnnotationView *cusView = (CusMAPinAnnotationView *)view;
        CGRect frame = [cusView convertRect:cusView.calloutView.frame toView:self.mapView];
        
        frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin));
        
        if (!CGRectContainsRect(self.mapView.frame, frame))
        {
            /* Calculate the offset to make the callout view show up. */
            CGSize offset = [self offsetToContainRect:frame inRect:self.mapView.frame];
            
            CGPoint theCenter = self.mapView.center;
            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
            
            CLLocationCoordinate2D coordinate = [self.mapView convertPoint:theCenter toCoordinateFromView:self.mapView];
            
            [self.mapView setCenterCoordinate:coordinate animated:YES];
        }
        
    }
}

#pragma mark - Drop Down Selector Delegate

- (void)dropDownControlView:(LHDropDownControlView *)view didFinishWithSelection:(id)selection {
    if (view.tag == 1) {
        view.title = [NSString stringWithFormat:@"省份: %@", selection ? : @"-"];
        [self updateCities:selection];
        self.cityDropDownController.title = [NSString stringWithFormat:@"城市: %@", selection ? [self.cities objectAtIndex:0] : @"-"];
        self.currentProvince = selection;
        self.currentCity = selection ? [self.cities objectAtIndex:0] : @"";
    } else {
        view.title = [NSString stringWithFormat:@"城市: %@", selection ? : @"-"];
        self.currentCity = selection;
    }
}

#pragma mark - Utility

- (void)setLabelText:(UILabel *)label
{
    if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"1"]) {
        label.text = @"骊住";
    } else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"2"]) {
        label.text = @"美标";
    } else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"]) {
        label.text = @"依奈";
    }
}

- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect
{
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
}

- (UIButton *)newButtonWithTitle:(NSString *)title
                          target:(id)target
                        selector:(SEL)selector
                           frame:(CGRect)frame
                           image:(UIImage *)image
                    imagePressed:(UIImage *)imagePressed
{
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
	[button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16.f];
	
	UIImage *newImage = [image stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newImage forState:UIControlStateNormal];
	
	UIImage *newPressedImage = [imagePressed stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newPressedImage forState:UIControlStateHighlighted];
	
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	
	button.backgroundColor = [UIColor clearColor];
	
	return button;
}

#pragma mark - Handle Action

- (void)animationAction:(UIButton *)sender
{
    if (self.paddingView.frame.size.width != 0) {
        [UIView animateWithDuration:1.f animations:^{
            self.paddingView.frame = (CGRect){.origin=self.paddingView.frame.origin, .size=CGSizeMake(0, self.paddingView.frame.size.height)};
            sender.frame = (CGRect){.origin=CGPointMake(100, 0), .size=sender.frame.size};
            self.container2.alpha=0;
            self.container.frame = CGRectMake(100, 50, 120, 50);
        } completion:^(BOOL finished) {
            self.container2.hidden=YES;
        }];
    } else {
        [UIView animateWithDuration:1.f animations:^{
            self.container2.hidden = NO;
            self.container2.alpha = 1;
            self.paddingView.frame = (CGRect){.origin=self.paddingView.frame.origin, .size=CGSizeMake(180, self.paddingView.frame.size.height)};
            sender.frame = (CGRect){.origin=CGPointMake(280, 0), .size=sender.frame.size};
            self.container.frame = CGRectMake(100, 50, 300, 600);
        } completion:^(BOOL finished) {
            
        }];
    }
}

// 处理下载(101)和截图(102)
- (void)handleTap:(UIGestureRecognizer *)recognizer
{
    switch (recognizer.view.tag) {
        case 101:
        {
            OfflineDetailViewController *detailViewController = [[OfflineDetailViewController alloc] init];
            detailViewController.mapView = self.mapView;
            
            detailViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:detailViewController];
            
            [self presentViewController:navi animated:YES completion:nil];
        }
            break;
        case 102:
            //        {
            //            ScreenshotViewController * screenshotViewController = [[ScreenshotViewController alloc] init];
            //            screenshotViewController.mapView = self.mapView;
            //            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:screenshotViewController];
            //            [self presentViewController:navi animated:YES completion:nil];
            //        }
            break;
        default:
            break;
    }
}

// 切换品牌 - 品牌选择
- (void)buttonClicked:(id)sender
{
    self.currentBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    ((UIButton *)sender).titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    self.currentBtn = sender;
}

// 点击确定按钮 － 搜索
- (void)defineBtnClicked:(id)sender
{
    [self updateStores];
    [self.tableView reloadData];
}

- (void)updateCities:(NSString *)province
{
    self.cities = [self.provincesAndCities objectForKey:province];
    [self.cityDropDownController setSelectionOptions:self.cities withTitles:self.cities];
    self.cityDropDownController.title = @"城市: -";
}

// 更新当前地址的门店信息
- (void)updateStores
{
    MAPointAnnotation *annotation1 = [[MAPointAnnotation alloc] init];
    annotation1.coordinate = CLLocationCoordinate2DMake(39.911447, 116.406026);
    annotation1.title      = @"sfdgsdfg";
    
    MAPointAnnotation *annotation2 = [[MAPointAnnotation alloc] init];
    annotation2.coordinate = CLLocationCoordinate2DMake(39.909698, 116.296248);
    annotation2.title      = @"sfdgsdfg";
    
    MAPointAnnotation *annotation3 = [[MAPointAnnotation alloc] init];
    annotation3.coordinate = CLLocationCoordinate2DMake(40.045837, 116.460577);
    annotation3.title      = @"adsfsad";
    
    Store *store1 = [[Store alloc] initWithStoreName:@"上海天下红星美凯龙店直北2店" storeAddress:@"真北路1008号G8185" storePhone:@"131456465" storeImage:nil storeAnnotation:annotation1];
    Store *store2 = [[Store alloc] initWithStoreName:@"上海海丽喜盈门店" storeAddress:@"宜山路320号117" storePhone:@"131456465" storeImage:nil storeAnnotation:annotation2];
    Store *store3 = [[Store alloc] initWithStoreName:@"上海臻好建配龙宝山店" storeAddress:@"长逸路15号1F8206" storePhone:@"131456465" storeImage:nil storeAnnotation:annotation3];
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:store1, store2, store3, nil];
    self.stores = arr;
}

#pragma mark - Initialization

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
}

- (void)initSearch
{
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 300, 600)];
    container.backgroundColor = [UIColor clearColor];
    // 品牌btn
    UIView *topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    topBarView.backgroundColor = [UIColor blackColor];
    topBarView.alpha = 0.8f;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self setLabelText:label];
    self.currentBrandLabel = label;
    [topBarView addSubview:label];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 180, 40)];
    self.paddingView = paddingView;
    paddingView.backgroundColor = [UIColor blackColor];
    paddingView.alpha = 0.8f;
    [container addSubview:paddingView];
    
    UIButton *animationButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 0, 20, 40)];
   // animationButton.backgroundColor = [UIColor greenColor];
    [animationButton setBackgroundImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    [animationButton addTarget:self action:@selector(animationAction:) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:animationButton];
    
//    UIButton *lizhu = [self newButtonWithTitle:@"骊住" target:self selector:@selector(buttonClicked:) frame:CGRectMake(0, 0, 100, 40) image:nil imagePressed:nil];
    // 默认选中骊住Button
//    [self buttonClicked:lizhu];
//    UIButton *meibiao = [self newButtonWithTitle:@"美标" target:self selector:@selector(buttonClicked:) frame:CGRectMake(100, 0, 100, 40) image:nil imagePressed:nil];
//    UIButton *yinai = [self newButtonWithTitle:@"伊奈" target:self selector:@selector(buttonClicked:) frame:CGRectMake(200, 0, 100, 40) image:nil imagePressed:nil];
//    [topBarView addSubview:lizhu];
//    [topBarView addSubview:meibiao];
//    [topBarView addSubview:yinai];
    [container addSubview:topBarView];
    
    UIView *container2 = [[UIView alloc] initWithFrame:CGRectMake(0, 45, 300, 555)];
    
    UIView *citySelectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)]; // 45
    citySelectView.backgroundColor = [UIColor blackColor];
    
    // 省份选择部分
    LHDropDownControlView *provinceDropDown = [[LHDropDownControlView alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
    provinceDropDown.title = @"省份: -";
    provinceDropDown.delegate = self;
    provinceDropDown.tag = 1;
    [provinceDropDown setSelectionOptions:self.provinces withTitles:self.provinces];
    [citySelectView addSubview:provinceDropDown];
    
    // 城市选择部分
    LHDropDownControlView *cityDropDown = [[LHDropDownControlView alloc] initWithFrame:CGRectMake(115, 5, 100, 30)];
    cityDropDown.title = @"城市: -";
    cityDropDown.delegate = self;
    cityDropDown.tag = 2;
    [cityDropDown setSelectionOptions:self.cities withTitles:self.cities];
    self.cityDropDownController = cityDropDown;
    [citySelectView addSubview:cityDropDown];
    
    // 确定按钮
    UIButton *define = [[UIButton alloc] initWithFrame:CGRectMake(240, 5, 40, 30)];
    [define addTarget:self action:@selector(defineBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    define.backgroundColor = [UIColor blackColor];
    [define setTitle:@"确定" forState:UIControlStateNormal];
    [define setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [citySelectView addSubview:define];
    
    [container2 addSubview:citySelectView];
    
    UIView *resultsView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 300, 600-85)];
    // 添加透明的背景图片
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, resultsView.frame.size.width, resultsView.frame.size.height)];
    backImage.image = [[UIImage imageNamed:@"dropdown_bg"]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    backImage.userInteractionEnabled = YES;
    resultsView.backgroundColor = [UIColor clearColor];
    [resultsView addSubview:backImage];
    //    resultsView.alpha = 0.7f;
    
    // TableView初始化
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 280, 600-85) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //    tableView.scrollEnabled = YES;
    self.tableView = tableView;
    [backImage addSubview:tableView];
    [container2 addSubview:resultsView];
    
    [container2 bringSubviewToFront:citySelectView];
    self.container2 = container2;
    [container addSubview:container2];
    self.container = container;
    [self.view addSubview:container];
}

- (void)initOtherView
{
    // 下载button
    UIImageView *downloadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(950, 550, 50, 50)];
    downloadImageView.backgroundColor = [UIColor blackColor];
    downloadImageView.alpha = 0.7f;
    downloadImageView.tag = 101;
    downloadImageView.userInteractionEnabled = YES;
    downloadImageView.image = [UIImage imageNamed:@"download"];
    
    [self.view addSubview:downloadImageView];
    // 截图button
    //    UIImageView *screenshotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(950, 490, 50, 50)];
    //    screenshotImageView.backgroundColor = [UIColor blackColor];
    //    screenshotImageView.alpha = 0.7f;
    //    screenshotImageView.tag = 102;
    //    screenshotImageView.userInteractionEnabled = YES;
    //    screenshotImageView.image = [UIImage imageNamed:@"screenshot"];
    //
    //    [self.view addSubview:screenshotImageView];
    
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [downloadImageView addGestureRecognizer:tapGestureRecognizer1];
    //    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    //    [screenshotImageView addGestureRecognizer:tapGestureRecognizer2];
}

// 初始化大头针
- (void)initAnnotations
{
    [self updateStores];
    self.annotations = [NSMutableArray array];
    for (Store *store in self.stores) {
        [self.annotations addObject:store.storeAnnotation];
    }
}
// 初始化城市
- (void)setupProvincesAndCities
{
    NSArray *henan = [NSArray arrayWithObjects:@"郑州", @"商丘", nil];
    NSArray *hebei = [NSArray arrayWithObjects:@"石家庄", nil];
    self.provincesAndCities = [NSDictionary dictionaryWithObjectsAndKeys: henan, @"河南", hebei, @"河北", @[@"上海"], @"上海", nil];
    self.provinces = [NSArray arrayWithObjects:@"河北", @"河南", @"上海", nil];
}

#pragma mark - Life Circle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // 初始化数据
        [self initAnnotations];
        [self setupProvincesAndCities];
        [self updateCities:self.currentProvince];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initMapView];
    
    [self initSearch];
    
    [self initOtherView];
    
    //[self.mapView addAnnotations:self.annotations];
    
    // 键值观察品牌变化
    [[LibraryAPI sharedInstance] addObserver:self forKeyPath:@"currentBrandID" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mapView showAnnotations:self.annotations animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[LibraryAPI sharedInstance] removeObserver:self forKeyPath:@"currentBrandID"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentBrandID"]) {
        [self setLabelText:self.currentBrandLabel];
    }
}

//CGAffineTransform tr = CGAffineTransformScale(self.container2.transform, 0, 0);
////    CGFloat h = self.container2.frame.size.height;
//[UIView animateWithDuration:2.5 delay:0 options:0 animations:^{
//    self.container2.center = CGPointMake(0, 45);
//    self.container2.transform = tr;
//    
//} completion:^(BOOL finished) {}];

@end
