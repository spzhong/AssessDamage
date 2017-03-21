//
//  UIButton+DCKit.h
//  Pods
//
//  Created by 黄登登 on 2016/12/30.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (DCKit)

// 原SD的调用方式 只是为了跟带缩略图的名称上调用方式统一 方便之后维护
- (void)dc_setImageWithURL:(NSString *)url forState:(UIControlState)state;
// 原SD的调用方式 只是为了跟带缩略图的名称上调用方式统一 方便之后维护
- (void)dc_setImageWithURL:(NSString *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder;


// 带缩略图的调用方式
- (void)dc_setImageDefaultThumbWithURL:(NSString *)url forState:(UIControlState)state;
// 带缩略图的调用方式
- (void)dc_setImageDefaultThumbWithURL:(NSString *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder;


@end
