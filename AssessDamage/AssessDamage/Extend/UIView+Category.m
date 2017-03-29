//
//  UIView+Category.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/21.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "UIView+Category.h"

#define  kUtilityUIDefaultBorderWidth                    0.5f
#define  kUtilityUIDefaultBorderCornerRadius             4.0f



@implementation UIView (Category)

- (void)setBorderOnView:(UIView *)view borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius {
    if (!view) {
        return;
    }
    
    borderColor = borderColor ? borderColor : [UIColor redColor];
    borderWidth = borderWidth >= 0 ? borderWidth : kUtilityUIDefaultBorderWidth;
    cornerRadius = cornerRadius >= 0 ? cornerRadius : kUtilityUIDefaultBorderCornerRadius;
    
    view.layer.borderColor = borderColor.CGColor;
    view.layer.borderWidth = borderWidth;
    view.layer.cornerRadius = cornerRadius;
    if (cornerRadius >= 0) {
        view.clipsToBounds = YES;
    }
}

- (void)setBorderOnView:(UIView *)view {
    [self setBorderOnView:view borderColor:view.backgroundColor borderWidth:kUtilityUIDefaultBorderWidth cornerRadius:kUtilityUIDefaultBorderCornerRadius];
}

- (void)setBorderOnView:(UIView *)view cornerRadius:(CGFloat)cornerRadius {
    [self setBorderOnView:view borderColor:view.backgroundColor borderWidth:0.0f cornerRadius:cornerRadius];
}

- (void)setBorderOnView:(UIView *)view borderColor:(UIColor *)borderColor{
    [self setBorderOnView:view borderColor:borderColor borderWidth:kUtilityUIDefaultBorderWidth cornerRadius:kUtilityUIDefaultBorderCornerRadius];
}

- (void)setLineOnView:(UIView *)view andSize:(CGSize)size
{
    UIView *lineTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, 0.5)];
    lineTop.backgroundColor = [UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:1.0];
    [view addSubview:lineTop];
    
    UIView *lineBottom = [[UIView alloc]initWithFrame:CGRectMake(0, size.height - 0.5, size.width, 0.5)];
    lineBottom.backgroundColor = [UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:1.0];
    [view addSubview:lineBottom];
}

- (void)setLineOnBottomView:(UIView *)view andSize:(CGSize)size
{
    UIView *lineBottom = [[UIView alloc]initWithFrame:CGRectMake(0, size.height - 0.5, size.width, 0.5)];
    lineBottom.backgroundColor = [UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:1.0];
    [view addSubview:lineBottom];
}

-(CGFloat)getX{
    return self.frame.origin.x;
}
-(CGFloat)getY{
    return self.frame.origin.y;
}
-(CGFloat)getW{
    return self.frame.size.width;
}
-(CGFloat)getH{
    return self.frame.size.height;
}


@end
