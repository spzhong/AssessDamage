//
//  NSString+DCKit.h
//  Pods
//
//  Created by 曾昭英 on 2016/12/23.
//
//

#import <Foundation/Foundation.h>

@interface NSString (DCKit)

- (NSString *)dc_md5;

//银行卡隐藏规则
- (NSString *)dc_bankNumhide;
//银行卡只显示4位
- (NSString *)dc_bank4Numhide;

// 时间戳转换成约定的时间格式 即yyyy-MM-dd HH:mm:ss
- (NSString *)dc_convertTsToTime;
// 时间戳转换成需要的时间格式 即format可以自行定义
- (NSString *)dc_convertTsToTimeWithFormat:(NSString *)format;

// 时间字符串转换成约定的时间格式 即yyyy-MM-dd HH:mm:ss
- (NSString *)dc_convertStringToTime;
// 时间字符串转换成需要的时间格式 即format可以自行定义
- (NSString *)dc_convertStringToTimeWithFormat:(NSString *)format;

- (UIColor *)dc_stringTOColor;

@end
