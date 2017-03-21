//
//  DCUtility.h
//  Pods
//
//  Created by 黄登登 on 2016/12/30.
//
//

#import <UIKit/UIKit.h>

@interface DCUtility : NSObject

+ (void)showLog:(NSString *)text;

// 振动和播放系统声音
+ (void)dc_shakeAndPlaySound;

// 在url里添加参数，要判断有无?和&
+ (NSString *)dc_doUrlStringAddPamameter:(NSString *)urlStr key:(NSString *)key value:(NSString *)value;

//计算文件大小
+ (NSString *)dc_fileSizeFromBytes:(unsigned long long)size;



@end
