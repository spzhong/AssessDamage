//
//  NSString+DCKit.m
//  Pods
//
//  Created by 曾昭英 on 2016/12/23.
//
//

#import "NSString+DCKit.h"
#import <CommonCrypto/CommonHMAC.h>

#define DC_kDateFormatDefault              @"yyyy-MM-dd HH:mm:ss"

@implementation NSString (DCKit)

- (NSString *)dc_md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr),result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//银行卡隐藏规则
-(NSString *)dc_bankNumhide:(NSString *)bankNum{
    if (self.length < 16) {
        return self;
    }
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"************"];
    [string appendString:[self substringWithRange:NSMakeRange(self.length-4, 4)]];
    return string;
}

//银行卡只显示4位
-(NSString *)dc_bank4Numhide{
    if (self.length < 16) {
        return self;
    }
    NSMutableString *string = [NSMutableString string];
    [string appendString:[self substringWithRange:NSMakeRange(self.length-4, 4)]];
    return string;
}

// 时间戳转换成约定的时间格式 即yyyy-MM-dd HH:mm:ss
- (NSString *)dc_convertTsToTime{
    return [self dc_convertTsToTimeWithFormat:DC_kDateFormatDefault];
}
// 时间戳转换成需要的时间格式 即format可以自行定义
- (NSString *)dc_convertTsToTimeWithFormat:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.length > 10?[[self substringToIndex:10] longLongValue]:[self longLongValue]];
    NSString* dateString = [formatter stringFromDate:date];
    
    return dateString;
    
}


// 时间字符串转换成约定的时间格式 即yyyy-MM-dd HH:mm:ss
- (NSString *)dc_convertStringToTime{
    [self dc_convertStringToTimeWithFormat:DC_kDateFormatDefault];
}
// 时间字符串转换成需要的时间格式 即format可以自行定义
- (NSString *)dc_convertStringToTimeWithFormat:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:DC_kDateFormatDefault];
    NSDate *date = [formatter dateFromString:self];
    
    NSDateFormatter *c_formatter = [[NSDateFormatter alloc] init];
    [c_formatter setDateFormat:format];
    NSString *dateString = [c_formatter stringFromDate:date];
    return dateString;
}

- (UIColor *)stringTOColor{
    
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[self substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[self substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[self substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

@end
