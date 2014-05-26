//
//  RTFlyoutMenu.m
//  RTFlyoutMenu
//
//  Created by Aleksandar Vacić on 27.11.12..
//  Copyright (c) 2012. Aleksandar Vacić. All rights reserved.
//

#import "RTFlyoutMenu.h"
#import "RTFlyoutItem.h"
#import "RTFlyoutMenuCell.h"


NSString *const RTFlyoutMenuUIOptionMenuMargins = @"kRTFlyoutMenuUIOptionMenuMargins";
NSString *const RTFlyoutMenuUIOptionInnerItemSize = @"kRTFlyoutMenuUIOptionInnerItemSize";
NSString *const RTFlyoutMenuUIOptionContentInsets = @"kRTFlyoutMenuUIOptionContentInsets";
NSString *const RTFlyoutMenuUIOptionAnimationDuration = @"kRTFlyoutMenuUIOptionAnimationDuration";
NSString *const RTFlyoutMenuUIOptionSubItemPaddings = @"kRTFlyoutMenuUIOptionSubItemPaddings";

@implementation RTFlyoutMenu



#pragma mark - Init

- (id)initWithDelegate:(id <RTFlyoutMenuDelegate>)delegate dataSource:(id <RTFlyoutMenuDataSource>)dataSource position:(RTFlyoutMenuPosition)position options:(NSDictionary *)options withTag:(int)tag withColor:(UIColor *)color {
    if (delegate && [delegate conformsToProtocol:@protocol(RTFlyoutMenuDelegate)]) {
        _delegate = delegate;
        _dataSource = dataSource;
		_menuTag = tag;
        _suiteColor = color;
        
		[self setupDefaults];

		_position = position;
		switch (position) {
			case kRTFlyoutMenuPositionTop:
				_unfoldDirection = kRTFlyoutMenuUnfoldDirectionBottom;
				break;
				
			case kRTFlyoutMenuPositionBottom:
				_unfoldDirection = kRTFlyoutMenuUnfoldDirectionTop;
				break;
				
			default:
				_unfoldDirection = kRTFlyoutMenuUnfoldDirectionBottom;
				break;
		}
		
		//	process options
		if (options) {
			[options enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
				if ([key isEqualToString:RTFlyoutMenuUIOptionContentInsets])
					self.contentInsets = [obj UIEdgeInsetsValue];
				else if ([key isEqualToString:RTFlyoutMenuUIOptionAnimationDuration])
					self.animationDuration = (CGFloat)[(NSNumber *)obj floatValue];
				else if ([key isEqualToString:RTFlyoutMenuUIOptionInnerItemSize])
					self.innerItemSize = [obj CGSizeValue];
				else if ([key isEqualToString:RTFlyoutMenuUIOptionMenuMargins])
					self.menuMargins = [obj UIEdgeInsetsValue];
				else if ([key isEqualToString:RTFlyoutMenuUIOptionSubItemPaddings])
					self.subItemInsets = [obj UIEdgeInsetsValue];
			}];
		}
		
        
        
        self = [self initWithFrame:CGRectZero];
		
		[self fetchData];
		[self renderMainMenu];
		
        // 初始化 UITableView对象
        // 动态初始化 tableView
        
        for (int i=0; i<self.mainItems.count; i++) {
           
          UITableView *itemTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 150, 0)];
            [self.subMenuTableViewList addObject:itemTableView];
            
            itemTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
    
        
		return self;
    }

    return nil;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {}
    
    return self;
}

- (void)setupDefaults {
	//	behavior
	_position = kRTFlyoutMenuPositionTop;
	_unfoldDirection = kRTFlyoutMenuUnfoldDirectionBottom;
	_indexOfOpenSubmenu = -1;

	//	look & feel
	_menuMargins = UIEdgeInsetsMake(1, 5, 1, 5);
	_contentInsets = UIEdgeInsetsMake(5, 5, 5, 5);
	_innerItemSize = CGSizeMake(22, 22);
	_mainItemInsets = UIEdgeInsetsMake(6, 15, 6, 15);
	_subItemInsets = UIEdgeInsetsMake(8, 15, 8, 15);
	_animationDuration = .2;
	_subItemsPerColumn = 20;
	
    
    _subItemsCellHeight = 33;
    _subMenuViewHeight = 500;
	//	data
	_numberOfMainItems = 0;
	_mainItemTitles = [NSMutableArray array];
	_subItemTitles = [NSMutableArray array];
	_selectedItemTitles = [NSMutableArray array];
	_subMenuTableViewList = [NSMutableArray array];
    
	//	rendered
	_mainItems = nil;
	_mainItemFrames = nil;
	_submenus = nil;
}


#pragma mark - Data source

- (void)fetchData {

	if ([self.dataSource respondsToSelector:@selector(numberOfMainItemsInFlyoutMenu:)]) {
		self.numberOfMainItems = [self.dataSource numberOfMainItemsInFlyoutMenu:self];

		_mainItems = [NSMutableArray arrayWithCapacity:self.numberOfMainItems];
		_mainItemFrames = [NSMutableArray arrayWithCapacity:self.numberOfMainItems];
		_submenus = [NSMutableDictionary dictionaryWithCapacity:self.numberOfMainItems];
	}

	if ([self.dataSource respondsToSelector:@selector(flyoutMenu:titleForMainItem:)]) {
		for (NSUInteger i = 0; i < self.numberOfMainItems; i++) {
			NSString *t = [self.dataSource flyoutMenu:self titleForMainItem:i];
			if ([t length] == 0) t = @"";
			[self.mainItemTitles addObject:t];
			[self.selectedItemTitles addObject:[NSNull null]];
		}
	}
	
	if ([self.dataSource respondsToSelector:@selector(flyoutMenu:numberOfItemsInSubmenu:)] && [self.dataSource respondsToSelector:@selector(flyoutMenu:titleForSubItem:inMainItem:)]) {

		for (NSUInteger i = 0; i < self.numberOfMainItems; i++) {
			NSUInteger numberOfSubItems = [self.dataSource flyoutMenu:self numberOfItemsInSubmenu:i];
			NSMutableArray *a = [NSMutableArray array];
			for (NSUInteger j = 0; j < numberOfSubItems; j++) {
				NSString *t = [self.dataSource flyoutMenu:self titleForSubItem:j inMainItem:i];
				if ([t length] == 0) t = @"";
				[a addObject:t];
			}
			[self.subItemTitles addObject:a];
            
            NSLog(@"subItemTitles is %@",_subItemTitles);
		}
	}
}


#pragma mark - Rendering

- (void)renderMainMenu {
	
	//UIFont *buttonFont = [UIFont fontWithName:@"AvenirNext-DemiBold" size:13.0];
	CGFloat currentX = self.contentInsets.left, currentY = self.contentInsets.top, itemHeight = 0;
	
	//	expands empty space to the right, making the separator appear on the left of the button
	UIImage *itemBgImage = [UIImage imageNamed:@"productlist_arrow"];
    

	//BOOL addedFirstButton = NO;
	for (NSString *mainTitle in self.mainItemTitles) {
		//CGSize titleTextSize = [mainTitle sizeWithFont:buttonFont constrainedToSize:CGSizeMake(1000, 1000)];
		//if (titleTextSize.height < self.innerItemSize.height) titleTextSize.height = self.innerItemSize.height;

		RTFlyoutItem *btn = [RTFlyoutItem buttonWithType:UIButtonTypeCustom];
		btn.mainItemIndex = [self.mainItemTitles indexOfObject:mainTitle];
		btn.subItemIndex = -1;
        
        // 如果是左边菜单的话 这只按钮图片
      if (self.menuTag == 1)
      {
          [btn setImage:[UIImage imageNamed:@"as_minamenu"] forState:UIControlStateNormal];
          //4个参数是上边界，左边界，下边界，右边界。
          btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //  [btn setTitleEdgeInsets:UIEdgeInsetsMake(4, -20, 0, 0)];
          [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 20)];
      }else {
         
          [btn setTitle:mainTitle forState:UIControlStateNormal];
          [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
         // [btn.titleLabel setTextColor:[UIColor whiteColor]];
          [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          
          [btn setImage:itemBgImage forState:UIControlStateNormal];
          btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
          //  [btn setTitleEdgeInsets:UIEdgeInsetsMake(4, -20, 0, 0)];
          [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 63, 10, 0)];

          
        //4个参数是上边界，左边界，下边界，右边界。
        
      }
		      
        [btn setFrame:CGRectMake(currentX, currentY, 70,30)];
		
        
		[btn addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
		
		currentX += btn.bounds.size.width;
		if (itemHeight < btn.bounds.size.height) itemHeight = btn.bounds.size.height;
		
     	[self addSubview:btn];
		[self.mainItems addObject:btn];
		[self.mainItemFrames addObject:[NSValue valueWithCGRect:btn.frame]];
		
	//	addedFirstButton = YES;
	}
    

	CGRect f = self.frame;
	f.size = CGSizeMake(currentX + self.contentInsets.right, itemHeight + self.contentInsets.top + self.contentInsets.bottom);
	self.frame = f;
 /*
   
	//	render background image
	UIImage *resizedBgImage = [[UIImage imageNamed:@"mainBackground.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 5, 23, 5)];
    UIImageView *mainBackgroundImageView = [[UIImageView alloc] initWithImage:resizedBgImage];
	mainBackgroundImageView.frame = (CGRect){.size=self.bounds.size};
	mainBackgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:mainBackgroundImageView];
    [self sendSubviewToBack:mainBackgroundImageView];
	
 
     
	self.clipsToBounds = NO;
   */
}

- (UIView *)renderSubmenuAtIndex:(NSUInteger)index {
	
	UIView *sv = nil;
	
	if ([self.submenus objectForKey:@(index)]) {
		sv = [self.submenus objectForKey:@(index)];

	} else {
        
        UIFont *buttonFont = [UIFont systemFontOfSize:15];
		//UIFont *mainItemFont = [UIFont fontWithName:@"AvenirNext-DemiBoldItalic" size:14.0];
        UIFont *mainItemFont = [UIFont systemFontOfSize:16];

		CGRect mainItemFrame = [[self.mainItemFrames objectAtIndex:index] CGRectValue];
     
        sv = [[UIView alloc] initWithFrame:CGRectZero];
		sv.clipsToBounds = YES;
		
		NSArray *subtitles = [self.subItemTitles objectAtIndex:index];
		
		if ([subtitles count] == 0) return sv;
		
        // 加载UITableView 子菜单内容
        self.subMenuItemList = [self.subItemTitles objectAtIndex:index];

        _mainMenuIndex = index;
        
		//CGFloat currentX = self.contentInsets.left, currentY = self.contentInsets.top;
        
        UITableView *tableView = (UITableView *)[self.subMenuTableViewList objectAtIndex:index];
        [tableView setTag:index];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView setBackgroundColor:[UIColor clearColor]];
        
        [tableView registerNib:[UINib nibWithNibName:@"RTFlyoutMenuCell" bundle:nil] forCellReuseIdentifier:@"RTFlyoutMenuCell"];
        
        // 计算TableView Frame 大小
		NSInteger numberOfItems = [subtitles count];
		NSInteger tvHeight = numberOfItems * self.subItemsCellHeight;
		//	prevent small columns: if number of left-over items is less than a number of columns, then add one more item to each column
		//	otherwise up the columns count by one (the / operation above cuts of the decimal part)
        if (tvHeight >= self.subMenuViewHeight)
        {
            tvHeight = self.subMenuViewHeight;
        }
        
        [tableView setFrame:CGRectMake(2, 2, 150, tvHeight)];
        [sv addSubview:tableView];
        [tableView reloadData];
        
		CGRect f = sv.frame;
		f.origin = CGPointMake(mainItemFrame.origin.x, mainItemFrame.origin.y + mainItemFrame.size.height - self.contentInsets.bottom);
//		f.origin.y = 0;	//	DEBUG!
		f.size = CGSizeMake(155,tvHeight+5);
		CGFloat diff = self.bounds.size.width - (f.origin.x + f.size.width);
		if (diff < 0) f.origin.x += diff;
		
        sv.frame = f;
        
		//	render background image
		UIImage *resizedBgImage = [[UIImage imageNamed:@"submenuBackground.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(24, 5, 25, 5)];
		UIImageView *bgImageView = [[UIImageView alloc] initWithImage:resizedBgImage];
		bgImageView.frame = (CGRect){.size=sv.bounds.size};
		bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		[sv addSubview:bgImageView];
		[sv sendSubviewToBack:bgImageView];
		
		[self.submenus setObject:sv forKey:@(index)];
	}

	return sv;
}

- (void)updateMainItem:(RTFlyoutItem *)item withTitle:(NSString *)newTitle {
	
	UIFont *buttonFont = item.titleLabel.font;
	CGSize titleTextSize = [newTitle sizeWithFont:buttonFont constrainedToSize:CGSizeMake(1000, 1000)];
	if (titleTextSize.height < self.innerItemSize.height) titleTextSize.height = self.innerItemSize.height;

	//	re-calculate main item frames, find the difference between old and new frame size for tapped item
	NSInteger itemIndex = [self.mainItems indexOfObject:item];
	CGRect oldItemFrame = [[self.mainItemFrames objectAtIndex:itemIndex] CGRectValue];
	CGSize newFrameSize = CGSizeMake(titleTextSize.width + self.mainItemInsets.left + self.mainItemInsets.right, titleTextSize.height + self.mainItemInsets.top + self.mainItemInsets.bottom);
	
	CGFloat diff = newFrameSize.width - oldItemFrame.size.width;
	if (diff == 0) return;

	//	update menu frame
	CGRect menuFrame = self.frame;
	menuFrame.origin.x -= diff;
	menuFrame.size.width += diff;
	
	//	update tapped item
	CGRect f = oldItemFrame;
	f.size = newFrameSize;
	[self.mainItemFrames replaceObjectAtIndex:itemIndex withObject:[NSValue valueWithCGRect:f]];
	
	//	update items after the tapped one
	NSUInteger framesCount = [self.mainItemFrames count];
	for (NSInteger i = itemIndex+1; i < framesCount; i++) {
		CGRect fi = [[self.mainItemFrames objectAtIndex:i] CGRectValue];
		fi.origin.x += diff;
		[self.mainItemFrames replaceObjectAtIndex:i withObject:[NSValue valueWithCGRect:fi]];
	}
	
	//	animate the change
	[UIView animateWithDuration:self.animationDuration animations:^{
		self.frame = menuFrame;
		for (NSInteger i = itemIndex; i < framesCount; i++) {
			CGRect fi = [[self.mainItemFrames objectAtIndex:i] CGRectValue];
			[(RTFlyoutItem *)[self.mainItems objectAtIndex:i] setFrame:fi];
		}
		
	} completion:^(BOOL finished) {
		[item setTitle:newTitle forState:UIControlStateNormal];
	}];
}

- (void)closeSubmenuAtIndex:(NSInteger)index {
	UIView *sv = [self renderSubmenuAtIndex:index];
	CGRect f = sv.frame, forig = f;
	f.size = CGSizeMake(f.size.width, 0);
	
	CGPoint originInCanvas = [self.canvasView convertPoint:forig.origin toView:self];
	forig.origin = originInCanvas;
	
	[UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationCurveEaseIn animations:^{
		sv.frame = f;
	} completion:^(BOOL finished) {
		[sv removeFromSuperview];
		sv.frame = forig;
	}];
}

- (void)openSubmenuAtIndex:(NSInteger)index {
	UIView *sv = [self renderSubmenuAtIndex:index];
    [_menuTableView reloadData];
	CGRect f = sv.frame, ffinal = f;
	f.size = CGSizeMake(f.size.width, 0);
	
	CGPoint originInCanvas = [self convertPoint:f.origin toView:self.canvasView];
	if (originInCanvas.x < 0)
		originInCanvas.x = 0;
	f.origin = originInCanvas;
	ffinal.origin = originInCanvas;
	
	sv.frame = f;
	[self.canvasView addSubview:sv];
	
	[UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationCurveEaseIn animations:^{
		sv.frame = ffinal;
	} completion:nil];
}


#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.subItemTitles objectAtIndex:_mainMenuIndex] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = @"RTFlyoutMenuCell";
    
    RTFlyoutMenuCell *cell = (RTFlyoutMenuCell*)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];

    NSUInteger row=[indexPath row];
    
    if ( self.subMenuItemList != nil && [self.subMenuItemList count]>=1 && row <= [self.subMenuItemList count]-1)
    {
        [cell.menuItem setTitle:[self.subMenuItemList objectAtIndex:row] forState:UIControlStateNormal];
        
        if (_suiteColor){
          
            [cell.ItemBottomLine setBackgroundColor:_suiteColor];
        } else {
          
            [cell.ItemBottomLine setBackgroundColor:AS_DefatuleColor];
            
        }
    
        [cell.menuItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        cell.menuItem.mainItemIndex = _mainMenuIndex;
        
        cell.menuItem.subItemIndex = row;
        
        cell.backgroundColor = [UIColor clearColor];
        
        [cell.menuItem addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

#pragma mark - Actions

- (void)itemTapped:(RTFlyoutItem *)sender {
//	NSLog(@"inner Button tap");
	
	BOOL isMainItem = (sender.subItemIndex == -1);
	//	if main item, then open/close that particular submenu
	if (isMainItem) {
		
		if (_indexOfOpenSubmenu == sender.mainItemIndex) {
			//	close this submenu
			[self closeSubmenuAtIndex:sender.mainItemIndex];
			_indexOfOpenSubmenu = -1;
			
		} else if (_indexOfOpenSubmenu > -1) {
			//	close previously submenu
			[self closeSubmenuAtIndex:self.indexOfOpenSubmenu];
			
			//	open tapped submenu
			[self openSubmenuAtIndex:sender.mainItemIndex];
			_indexOfOpenSubmenu = sender.mainItemIndex;

		} else {
			//	open this submenu
			[self openSubmenuAtIndex:sender.mainItemIndex];
			_indexOfOpenSubmenu = sender.mainItemIndex;
			
		}

	} else {
		//	if subitem, then update main item text
		//RTFlyoutItem *mainBtn = [self.mainItems objectAtIndex:sender.mainItemIndex];
		//NSString *subTitle = [sender titleForState:UIControlStateNormal];
		
        /* 屏蔽掉 eddt - 0228*/
        //[self updateMainItem:mainBtn withTitle:subTitle];

		//	and close the submenu
		[self closeSubmenuAtIndex:self.indexOfOpenSubmenu];
		_indexOfOpenSubmenu = -1;
	}
	
	if (isMainItem) {
		[self.selectedItemTitles replaceObjectAtIndex:sender.mainItemIndex withObject:[NSNull null]];
	} else {
		if (sender.subItemIndex < 0) {
			//	going back to main item
			[self.selectedItemTitles replaceObjectAtIndex:sender.mainItemIndex withObject:[NSNull null]];
		} else {
			NSString *subTitle = [sender titleForState:UIControlStateNormal];
			[self.selectedItemTitles replaceObjectAtIndex:sender.mainItemIndex withObject:subTitle];
		}
	}

	//	inform delegate
	if (isMainItem && [self.delegate respondsToSelector:@selector(flyoutMenu:didSelectMainItemWithIndex:)]) {
		[self.delegate flyoutMenu:self didSelectMainItemWithIndex:sender.mainItemIndex];
	} else if ([self.delegate respondsToSelector:@selector(flyoutMenu:didSelectSubItemWithIndex:mainMenuItemIndex:)]) {
		[self.delegate flyoutMenu:self didSelectSubItemWithIndex:sender.subItemIndex mainMenuItemIndex:sender.mainItemIndex];
	}
}

- (void)reset {
	
	//	reset picks saver
	[self.selectedItemTitles removeAllObjects];
	
	//	close any open submenus
	if (self.indexOfOpenSubmenu > -1) {
		[self closeSubmenuAtIndex:self.indexOfOpenSubmenu];
		self.indexOfOpenSubmenu = -1;
	}
	
	//	revert main items to defaults
	for (NSInteger i=0; i < [self.mainItemTitles count]; i++) {
		NSString *s = [self.mainItemTitles objectAtIndex:i];
		RTFlyoutItem *mainBtn = [self.mainItems objectAtIndex:i];
		NSString *t = [mainBtn titleForState:UIControlStateNormal];
		if (![s isEqualToString:t])
			[self updateMainItem:mainBtn withTitle:s];
		//	also populate dummy objects here
		[self.selectedItemTitles addObject:[NSNull null]];
	}
	
}

- (void)reloadData {
	
	//	reset
	[self.submenus removeAllObjects];
	[self.mainItemFrames removeAllObjects];
	[self.mainItemTitles removeAllObjects];
	[self.selectedItemTitles removeAllObjects];
	[self.subItemTitles removeAllObjects];
	self.numberOfMainItems = 0;
	self.indexOfOpenSubmenu = -1;

	//	remove menu
	[self removeFromSuperview];
	//	clear everything
	self.frame = CGRectZero;
	
	//	get data
	[self fetchData];
	//	re-render
	[self renderMainMenu];

	//	here delegate must re-add the menu to its container
	if ([self.delegate respondsToSelector:@selector(didReloadFlyoutMenu:)])
		[self.delegate didReloadFlyoutMenu:self];
}

@end
