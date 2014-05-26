//
//  RetailStoresViewController.m
//  ShowCasePro
//
//  Created by lvpw on 14-2-20.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "RetailStoresViewController.h"
#import "RetailStoresTableViewCell.h"
#import "MacroDefine.h"
#import "ProvinceCityMenuViewController.h"
#import "GenericDao+Tprovince.h"
#import "GenericDao+Tcity.h"
#import "Tprovince.h"
#import "Tcity.h"
#import <MAMapKit/MAMapKit.h>
#import "CusMAPinAnnotationView.h"

#import "GenericDao+Twarehouse.h"
#import "Twarehouse.h"

#define kCalloutViewMargin          -8
#define RetailStoresTableViewCellIdentifier @"RetailStoresTableViewCellIdentifier"

@interface RetailStoresViewController () <UITableViewDataSource, UITableViewDelegate, ProvinceCityMenuViewControllerDelegate, MAMapViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *retailStoresMapView;
@property (strong, nonatomic) IBOutlet UILabel *provinceLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UITableView *retailStoreDetailsTableView;
@property (strong, nonatomic) NSArray *retailStoreDetails;
@property (strong, nonatomic) ProvinceCityMenuViewController *provinceCityMenuViewController;
@property (nonatomic, strong) NSArray *provinces;
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) MAMapView *mapView;
@property NSInteger index;
@property (nonatomic, strong) MAPointAnnotation *annotation;
@property (nonatomic, strong) NSMutableArray *annotations;

- (IBAction)littleSearchBtnClicked:(id)sender;
- (IBAction)provinceAction:(UIButton *)sender;
- (IBAction)cityAction:(UIButton *)sender;
- (IBAction)backgroundClickedAction:(id)sender;

@end

@implementation RetailStoresViewController

#pragma mark - ovverride

- (NSMutableArray *)annotations
{
    if (!_annotations) {
        _annotations = [NSMutableArray array];
    }
    return _annotations;
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
            //            NSInteger index = [self.annotations indexOfObject:annotation];
            annotationView.warehouse = [self.retailStoreDetails objectAtIndex:self.index];
            // 设置为NO 目的是弹出自定义的calloutView
            annotationView.canShowCallout = YES;
            annotationView.animatesDrop = YES;
            annotationView.draggable = NO;
        }
        annotationView.pinColor = MAPinAnnotationColorRed;
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
    int index = [self.annotations indexOfObject:view.annotation];
    [self.mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
    [self.mapView setZoomLevel:12 animated:YES];
    [self.retailStoreDetailsTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark - ProvinceCityMenuViewControllerDelegate

- (void)provinceCityMenuViewController:(ProvinceCityMenuViewController *)provinceCityMenuViewController didSelectedIndex:(NSInteger)index
{
    if ([provinceCityMenuViewController.type isEqualToString:@"province"]) {
        Tprovince *province = self.provinces[index];
        self.provinceLabel.text = province.province;
        self.provinceLabel.tag = [province.tprovinceid integerValue];
        GenericDao *cityDAO = [[GenericDao alloc] initWithClassName:@"Tcity"];
        self.cities = [cityDAO selectObjectsBy:@"provinceid" withValue:province.tprovinceid options:@{@"tcityid": @"id"}];
        Tcity *city = self.cities[0];
        self.cityLabel.text = city.city;
        self.cityLabel.tag = [city.tcityid integerValue];
    } else {
        Tcity *city = self.cities[index];
        self.cityLabel.text = city.city;
        self.cityLabel.tag = [city.tcityid integerValue];
    }
    [self littleSearchBtnClicked:nil];
    [provinceCityMenuViewController.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.1];
    provinceCityMenuViewController.isShow = NO;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.annotation != nil) {
//        [self.mapView removeAnnotation:self.annotation];
//    }
//    Twarehouse *warehouse = self.retailStoreDetails[indexPath.row];
//    CGFloat longtitude = [warehouse.longtitude doubleValue];
//    CGFloat latitude = [warehouse.lititude doubleValue];
//    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
//    annotation.coordinate = CLLocationCoordinate2DMake(latitude, longtitude);
//    annotation.title = warehouse.name;
//    self.index = indexPath.row;
//    self.annotation = annotation;
//    [self.mapView addAnnotation:annotation];
//    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(latitude, longtitude) animated:YES];
    [self.mapView setZoomLevel:12 animated:YES];
    [self.mapView selectAnnotation:[self.annotations objectAtIndex:[indexPath row]] animated:YES];
    [self.mapView setCenterCoordinate:((MAPointAnnotation *)[self.annotations objectAtIndex:[indexPath row]]).coordinate animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Twarehouse *warehouse = self.retailStoreDetails[indexPath.row];
    NSString *name = warehouse.name;
    NSString *address = warehouse.address;
//    CGSize size = [name sizeWithFont:[UIFont systemFontOfSize:13] forWidth:175 lineBreakMode:NSLineBreakByWordWrapping];
//    CGSize size1 = [address sizeWithFont:[UIFont systemFontOfSize:13] forWidth:175 lineBreakMode:NSLineBreakByWordWrapping];
//    NSDictionary *dict = [[[UIFont systemFontOfSize:25] fontDescriptor] fontAttributes];
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:13]};
    CGRect rect = [name boundingRectWithSize:CGSizeMake(175, 160) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    CGRect rect1 = [address boundingRectWithSize:CGSizeMake(175, 160) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
//    NSLog(@"dict:%@", dict);
//    NSLog(@"size:%@", NSStringFromCGSize(size));
//    NSLog(@"size1:%@", NSStringFromCGSize(size1));
//    NSLog(@"rect:%@", NSStringFromCGRect(rect));
//    NSLog(@"rect1:%@", NSStringFromCGRect(rect1));
//    NSLog(@"%.0f", (rect.size.height-16+rect.size.height/15.5*0.5)+(rect1.size.height-16+rect1.size.height/15.5*0.5));
    return 44.f+(rect.size.height-16+rect.size.height/15.5*0.5)+(rect1.size.height-16+rect1.size.height/15.5*0.5);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.retailStoreDetails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RetailStoresTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RetailStoresTableViewCellIdentifier forIndexPath:indexPath];
    Twarehouse *warehouse = self.retailStoreDetails[indexPath.row];
    cell.name.text = warehouse.name;
    cell.address.text = warehouse.address;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 5, cell.frame.size.width-10, cell.frame.size.height-10)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.frame;
    gradient.colors = @[(id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:82/255. green:82/255. blue:82/255. alpha:1].CGColor,
                        (id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor];
    gradient.cornerRadius = 8;
    [view.layer insertSublayer:gradient atIndex:0];
    view.backgroundColor = [UIColor colorWithRed:99/255. green:99/255. blue:99/255. alpha:1];
    cell.selectedBackgroundView = view;
    return cell;
}

#pragma mark - Init

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.retailStoresMapView.bounds];
    self.mapView.delegate = self;
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    [self.retailStoresMapView addSubview:self.mapView];
// (220852032.0, 101508584.0, 325416.5, 423041.4)  (220880104, 101476980, 272496, 466656)
//    self.mapView.visibleMapRect = MAMapRectMake(220852032.0, 101508584.0, 325416.5, 423041.4);
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(36.277908, 104.545559);
    [self.mapView setZoomLevel:4.0];
}

- (void)initTableView
{
    [self.retailStoreDetailsTableView registerNib:[UINib nibWithNibName:@"RetailStoresTableViewCell" bundle:nil] forCellReuseIdentifier:RetailStoresTableViewCellIdentifier];
}

// 初始化城市
- (void)setupProvincesAndCities
{
    GenericDao *provinceDAO = [[GenericDao alloc] initWithClassName:@"Tprovince"];
    self.provinces = [provinceDAO selectAllByOptions:@{@"tprovinceid": @"id"}];
    GenericDao *cityDAO = [[GenericDao alloc] initWithClassName:@"Tcity"];
    self.cities = [cityDAO selectObjectsBy:@"provinceid" withValue:((Tprovince *)self.provinces[0]).tprovinceid options:@{@"tcityid": @"id"}];
}

- (void)initProvinceCityMenuViewController
{
    if (self.provinceCityMenuViewController == nil) {
        self.provinceCityMenuViewController = [[ProvinceCityMenuViewController alloc] initWithNibName:@"ProvinceCityMenuViewController" bundle:nil];
        self.provinceCityMenuViewController.delegate = self;
    }
}

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setupProvincesAndCities];
        self.retailStoreDetails = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTableView];
    [self initMapView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self littleSearchBtnClicked:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Handle Action

- (IBAction)littleSearchBtnClicked:(id)sender {
    GenericDao *storeDao = [[GenericDao alloc] initWithClassName:@"Twarehouse"];
    NSArray *arr = [storeDao selectObjectsBy:@"cityid" withValue:[NSString stringWithFormat:@"%d", self.cityLabel.tag] options:@{@"twarehouseid":@"id"}];
    self.retailStoreDetails = arr;
    [self.retailStoreDetailsTableView reloadData];
    
    
    [self.mapView removeAnnotations:self.annotations];
    [self.annotations removeAllObjects];
    for (Twarehouse *twarehouse in self.retailStoreDetails) {
        CGFloat longtitude = [twarehouse.longtitude doubleValue];
        CGFloat latitude = [twarehouse.lititude doubleValue];
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longtitude);
        annotation.title = twarehouse.name;
        [self.annotations addObject:annotation];
    }
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(36.277908, 104.545559);
    [self.mapView setZoomLevel:4.0 animated:YES];
    [self.mapView addAnnotations:self.annotations];
}

- (IBAction)provinceAction:(UIButton *)sender
{
    [self initProvinceCityMenuViewController];
    _provinceCityMenuViewController.menuData = self.provinces;
    _provinceCityMenuViewController.type = @"province";
    CGRect endRect = [sender.superview convertRect:self.provinceLabel.frame toView:self.navigationController.topViewController.view];
    [_provinceCityMenuViewController showFromRect:endRect inView:self.view animated:NO];
}

- (IBAction)cityAction:(UIButton *)sender
{
    [self initProvinceCityMenuViewController];
    _provinceCityMenuViewController.menuData = self.cities;
    _provinceCityMenuViewController.type = @"city";
    CGRect endRect = [sender.superview convertRect:self.cityLabel.frame toView:self.navigationController.topViewController.view];
    [_provinceCityMenuViewController showFromRect:endRect inView:self.view animated:NO];
}

- (IBAction)backgroundClickedAction:(id)sender {
    [self dismissMenuView];
//    NSLog(@"%f, %f", self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude);
}

#pragma mark - Util

- (void)dismissMenuView
{
    if (_provinceCityMenuViewController.isShow) {
        [_provinceCityMenuViewController.view removeFromSuperview];
        _provinceCityMenuViewController.isShow = NO;
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

@end
