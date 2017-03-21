//
//  UIImage+DCKit.m
//  Pods
//
//  Created by 黄登登 on 2017/2/14.
//
//

#import "UIImage+DCKit.h"

@implementation UIImage (DCKit)

+ (UIImage *)dc_imageWithColor:(UIColor *)color
{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
