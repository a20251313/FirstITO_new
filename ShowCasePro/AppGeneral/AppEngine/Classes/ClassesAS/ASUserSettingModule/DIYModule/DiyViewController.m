//
//  DiyViewController.m
//  ShowCasePro
//
//  Created by yczx on 13-11-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DiyViewController.h"

#import "FindersViewController.h"
#import "MacroDefine.h"

@interface DiyViewController ()

@property (nonatomic, strong) FindersViewController *foldersViewController;

@end

@implementation DiyViewController

#pragma mark - Handle Action 

- (void)addAction:(id)sender{
    [self.foldersViewController addAction:sender];
}

- (void)editAction:(id)sender{
    [self.foldersViewController editAction:sender];
}

#pragma mark - Init

- (void)initFindersView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 44)];
    UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(63, 11, 20, 20)];
    UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(956, 8, 28, 28)];
    [left setImage:[UIImage imageNamed:@"jia-white"] forState:UIControlStateNormal];
    [right setTitle:@"编辑" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [right setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    right.titleLabel.font = [UIFont systemFontOfSize:14.f];
    buttonView.backgroundColor = [UIColor colorWithRed:91./255 green:91./255 blue:91./255 alpha:1];
    [left addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [right addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:left];
    [buttonView addSubview:right];
    [view addSubview:buttonView];
    
    FindersViewController *findersViewController = [[FindersViewController alloc] initWithNibName:@"FindersViewController" bundle:nil];
    findersViewController.view.frame = CGRectMake(25, 54, 974, 748);
    _foldersViewController = findersViewController;
    _foldersViewController.collectionView.backgroundColor = [UIColor colorWithRed:44./255. green:44./255. blue:44./255. alpha:1];
    self.view.backgroundColor = mRGBColor(44., 44., 44.);
    [view addSubview:findersViewController.view];
    [self addChildViewController:_foldersViewController];
    [self.view addSubview:view];
}

- (void)initButtonItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction:)];
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
    
    [self initFindersView];
    
//    [self initButtonItem];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
