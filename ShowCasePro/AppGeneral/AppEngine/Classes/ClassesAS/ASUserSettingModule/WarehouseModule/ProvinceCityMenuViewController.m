//
//  ProvinceCityMenuViewController.m
//  ShowCasePro
//
//  Created by lvpw on 14-2-20.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ProvinceCityMenuViewController.h"
#import "Tprovince.h"
#import "Tcity.h"
#define ProvinceCityTableViewCellIdentifier @"ProvinceCityTableViewCellIdentifier"

@interface ProvinceCityMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ProvinceCityMenuViewController

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(provinceCityMenuViewController:didSelectedIndex:)]) {
        [self.delegate provinceCityMenuViewController:self didSelectedIndex:indexPath.row];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProvinceCityTableViewCellIdentifier forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 61, 22)];
        label.tag = 100;
        label.textColor = [UIColor whiteColor];;
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:label];
    }
    NSObject *object = self.menuData[indexPath.row];
    if ([_type isEqualToString:@"province"]) {
        label.text = ((Tprovince *)object).province;
    } else label.text = ((Tcity *)object).city;
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

#pragma mark - Init

- (void)initTableView
{
    [self.provinceCityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ProvinceCityTableViewCellIdentifier];
}

#pragma mark - Life Cycle

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
    [self initTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated
{
    self.view.frame = (CGRect){.origin=CGPointMake(rect.origin.x, rect.origin.y+rect.size.height), .size=self.view.frame.size};
    [self.provinceCityTableView reloadData];
    [view addSubview:self.view];
    _isShow = YES;
}

@end
