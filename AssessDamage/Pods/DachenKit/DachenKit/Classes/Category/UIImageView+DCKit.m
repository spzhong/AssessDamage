//
//  UIImageView+DCKit.m
//  Pods
//
//  Created by 黄登登 on 2016/12/30.
//
//

#import "UIImageView+DCKit.h"

@implementation UIImageView (DCKit)

- (void)dc_setImageWithURL:(NSString *)url{
    [self dc_setImageWithURL:url placeholderImage:nil];
}
- (void)dc_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)dc_setImageWithURL:(NSString *)url completed:(SDWebImageCompletionBlock)completedBlock{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)dc_setImageDefaultThumbWithURL:(NSString *)url{
    [self dc_setImageDefaultThumbWithURL:url placeholderImage:nil];
}

- (void)dc_setImageDefaultThumbWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder{
    url = [NSString stringWithFormat:@"%@-small1",url];
    [self dc_setImageWithURL:url placeholderImage:placeholder];
}

@end
