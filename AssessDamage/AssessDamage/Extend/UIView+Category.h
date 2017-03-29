//
//  UIView+Category.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/21.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
 
- (void)setBorderOnView:(UIView *)view;
- (void)setBorderOnView:(UIView *)view borderColor:(UIColor *)borderColor;
- (void)setBorderOnView:(UIView *)view cornerRadius:(CGFloat)cornerRadius;
- (void)setBorderOnView:(UIView *)view borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;
- (void)setLineOnView:(UIView *)view andSize:(CGSize)size;
- (void)setLineOnBottomView:(UIView *)view andSize:(CGSize)size;

-(CGFloat)getX;
-(CGFloat)getY;
-(CGFloat)getW;
-(CGFloat)getH;


@end
