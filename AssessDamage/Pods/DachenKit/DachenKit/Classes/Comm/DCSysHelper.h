//
//  SysHelper.h
//  Pods
//
//  Created by 黄登登 on 2017/2/14.
//
//

#import <Foundation/Foundation.h>

@interface DCSysHelper : NSObject

+ (UIWindow *)dc_getCurrentShowWindow;

// 检测通讯录服务权限
+ (void)dc_CheckAddressBookAuthorization:(void (^)(BOOL isAuthorized))AuthorBlock;

// 检测定位服务权限
+ (void)dc_CheckLocationAuthorization:(void (^)(BOOL isAuthorized))AuthorBlock;

// 检测照片库服务权限
+ (void)dc_CheckAssetLibraryAuthorization:(void (^)(BOOL isAuthorized))AuthorBlock;

// 检测蓝牙服务权限
+ (void)dc_CheckPeripheralAuthorization:(void (^)(BOOL isAuthorized))AuthorBlock;

// 检测摄像头服务权限
+ (void)dc_CheckCameraAuthorization:(void (^)(BOOL isAuthorized))AuthorBlock;

// 检测麦克风服务权限
+ (void)dc_CheckMicrophoneAuthorization:(void (^)(BOOL isAuthorized))AuthorBlock;

@end
