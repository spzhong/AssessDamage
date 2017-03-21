//
//  UILabel+DCKit.h
//  Pods
//
//  Created by 黄登登 on 2017/2/10.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (DCKit)

- (void)dc_RichLabelColor:(NSRange)range color:(UIColor *)color;
- (void)dc_RichLabelFont:(NSRange)range font:(UIFont *)font;
// 设置label中部分文字的变色显示
- (void)dc_RichLabelColorWithFont:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor;

@end
