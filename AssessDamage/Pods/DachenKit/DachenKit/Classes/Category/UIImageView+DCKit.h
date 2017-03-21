//
//  UIImageView+DCKit.h
//  Pods
//
//  Created by 黄登登 on 2016/12/30.
//
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (DCKit)

// 原SD的调用方式 只是为了跟带缩略图的名称上调用方式统一 方便之后维护
- (void)dc_setImageWithURL:(NSString *)url;
// 原SD的调用方式 只是为了跟带缩略图的名称上调用方式统一 方便之后维护
- (void)dc_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder;

- (void)dc_setImageWithURL:(NSString *)url completed:(SDWebImageCompletionBlock)completedBlock;

// 带缩略图的调用方式
- (void)dc_setImageDefaultThumbWithURL:(NSString *)url;
// 带缩略图的调用方式
- (void)dc_setImageDefaultThumbWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder;



@end
