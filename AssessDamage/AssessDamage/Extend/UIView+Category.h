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


- (void)setBorderOnView;
- (void)setBorderOnViewBorderColor:(UIColor *)borderColor;
- (void)setBorderOnViewCornerRadius:(CGFloat)cornerRadius;
- (void)setBorderOnViewBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;

 


@end
