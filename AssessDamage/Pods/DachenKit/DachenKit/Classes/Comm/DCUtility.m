//
//  DCUtility.m
//  Pods
//
//  Created by 黄登登 on 2016/12/30.
//
//

#import "DCUtility.h"
#import "DCUtilsMacro.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation DCUtility



+ (void)dc_shakeAndPlaySound
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(1007);
}

// 在url里添加参数，要判断有无?和&
+ (NSString *)dc_doUrlStringAddPamameter:(NSString *)urlStr key:(NSString *)key value:(NSString *)value {
    if (!StringNotEmpty(urlStr)) {
        return nil;
    }
    
    if (!StringNotEmpty(key) || !StringNotEmpty(value)) {
        return [urlStr copy];
    }
    
    NSString *retString = nil;
    NSString *catStr = @"?";
    NSRange range = [urlStr rangeOfString:catStr];
    if (range.location != NSNotFound) {
        catStr = @"&";
    }
    NSString *suffStr = [NSString stringWithFormat:@"%@%@=%@", catStr, key, value];
    if (StringNotEmpty(suffStr)) {
        urlStr = [urlStr stringByAppendingString:suffStr];
    }
    retString = [urlStr copy];
    return retString;
}

+ (NSString *)dc_fileSizeFromBytes:(unsigned long long)size
{
    NSString *str;
    if(size < 1024)
        str = [NSString stringWithFormat:@"%llu bytes",size];
    else if (size < 1024*1024)
        str = [NSString stringWithFormat:@"%llu KB",size/1024];
    else if (size < 1024*1024*1024)
        str = [NSString stringWithFormat:@"%llu MB",size/(1024*1024)];
    return str;
}



@end
