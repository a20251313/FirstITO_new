//
//  CusMAPinAnnotationView.m
//  MapDemo
//
//  Created by CY-004 on 13-11-13.
//  Copyright (c) 2013年 CY. All rights reserved.
//

#define kCalloutWidth   200.0
#define kCalloutHeight  120.0

#import "CusMAPinAnnotationView.h"
#import "CustomCalloutView.h"

@implementation CusMAPinAnnotationView
// 覆盖父类方法，弹出calloutView
/*
- (void) setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected) {
        return;
    }
    
    if (selected) {
        if (self.calloutView == nil) {
            NSString *dian;
            NSString *address1;
            NSString *phone;
            if (_store==nil) {
                dian = _warehouse.name;
                address1 = _warehouse.address;
                phone = _warehouse.phone;
            } else {
                dian = _store.stroreName;
                address1 = _store.storeAddress;
                phone =_store.storePhone;
            }
            NSInteger len = dian.length > address1.length ? dian.length : address1.length;
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth + 12*len, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.bounds) / 2.f +self.calloutOffset.y-25.0);
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
            imageView.image = [UIImage imageNamed:@""];
            imageView.backgroundColor = [UIColor blackColor];
            [self.calloutView addSubview:imageView];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 30)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor whiteColor];
            name.text = [NSString stringWithFormat:@"门店名称:%@", dian];
            [name sizeToFit];
            
            UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, 100, 30)];
            address.backgroundColor = [UIColor clearColor];
            address.textColor = [UIColor whiteColor];
            address.text = [NSString stringWithFormat:@"门店地址:%@", address1];
            [address sizeToFit];
            
            UILabel *phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 70, 100, 30)];
            phoneLbl.backgroundColor = [UIColor clearColor];
            phoneLbl.textColor = [UIColor whiteColor];
            phoneLbl.text = [NSString stringWithFormat:@"门店电话:%@", phone];
            [phoneLbl sizeToFit];
            
            [self.calloutView addSubview:address];
            [self.calloutView addSubview:name];
            [self.calloutView addSubview:phoneLbl];
            
        }
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    [super setSelected:selected animated:animated];
}
*/
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    if (!inside && self.selected) {
        inside = [self.calloutView pointInside:[self convertPoint:point fromView:self.calloutView] withEvent:event];
    }
    return inside;
}

@end
