//
//  UIView+Category.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/21.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

@property CGPoint origin;
@property CGSize size;
@property CGFloat height;
@property CGFloat width;
@property CGFloat top;
@property CGFloat left;
@property CGFloat bottom;
@property CGFloat right;


- (void)setBorderOnView:(UIView *)view;
- (void)setBorderOnView:(UIView *)view borderColor:(UIColor *)borderColor;
- (void)setBorderOnView:(UIView *)view cornerRadius:(CGFloat)cornerRadius;
- (void)setBorderOnView:(UIView *)view borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;
- (void)setLineOnView:(UIView *)view andSize:(CGSize)size;
- (void)setLineOnBottomView:(UIView *)view andSize:(CGSize)size;

 


@end
