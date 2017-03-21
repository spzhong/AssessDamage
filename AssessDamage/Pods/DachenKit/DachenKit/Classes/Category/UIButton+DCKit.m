//
//  UIButton+DCKit.m
//  Pods
//
//  Created by 黄登登 on 2016/12/30.
//
//

#import "UIButton+DCKit.h"
#import "UIButton+WebCache.h"

@implementation UIButton (DCKit)

- (void)dc_setImageWithURL:(NSString *)url forState:(UIControlState)state{
    [self dc_setImageWithURL:url forState:state placeholderImage:nil];
}

- (void)dc_setImageWithURL:(NSString *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder{
    [self sd_setImageWithURL:[NSURL URLWithString:url] forState:state placeholderImage:placeholder options:0 completed:nil];
}

- (void)dc_setImageDefaultThumbWithURL:(NSString *)url forState:(UIControlState)state{
    [self dc_setImageDefaultThumbWithURL:url forState:state placeholderImage:nil];
}

- (void)dc_setImageDefaultThumbWithURL:(NSString *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder{
    url = [NSString stringWithFormat:@"%@-small1",url];
    [self dc_setImageWithURL:url forState:state placeholderImage:placeholder];
}

@end
