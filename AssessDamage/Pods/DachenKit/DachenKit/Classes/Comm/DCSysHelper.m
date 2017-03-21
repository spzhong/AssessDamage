//
//  SysHelper.m
//  Pods
//
//  Created by 黄登登 on 2017/2/14.
//
//

#import "DCSysHelper.h"
#import <AddressBook/AddressBook.h>
#import <CoreLocation/CLLocationManager.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <AVFoundation/AVFoundation.h>

@implementation DCSysHelper

+ (UIWindow *)dc_getCurrentShowWindow {
    UIWindow *currentShowWindow = nil;
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            currentShowWindow = window;
            break;
        }
    }
    return currentShowWindow;
}

// 检测通讯录服务权限
+ (void)dc_CheckAddressBookAuthorization:(void (^)(BOOL isAuthorized))AuthorBlock
{
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    
    if (kABAuthorizationStatusAuthorized == authStatus) {
        //授权成功，执行后续操作
        AuthorBlock(YES);
    }else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AuthorBlock(NO);
        });
    }
}

// 检测定位服务权限
+ (void)dc_CheckLocationAuthorization:(void (^)(BOOL isAuthorized))AuthorBlock
{
    CLAuthorizationStatus authStatus = [CLLocationManager  authorizationStatus];
    
    if (kCLAuthorizationStatusAuthorized == authStatus) {
        //授权成功，执行后续操作
        AuthorBlock(YES);
    }else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AuthorBlock(NO);
        });
    }
}

// 检测照片库服务权限
+ (void)dc_CheckAssetLibraryAuthorization:(void (^)(BOOL isAuthorized))AuthorBlock
{
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    
    if (ALAuthorizationStatusAuthorized == authStatus) {
        //授权成功，执行后续操作
        AuthorBlock(YES);
    }else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AuthorBlock(NO);
        });
    }
}

// 检测蓝牙服务权限
+ (void)dc_CheckPeripheralAuthorization:(void (^)(BOOL isAuthorized))AuthorBlock
{
    CBPeripheralManagerAuthorizationStatus authStatus = [CBPeripheralManager authorizationStatus];
    
    if (CBPeripheralManagerAuthorizationStatusAuthorized == authStatus) {
        //授权成功，执行后续操作
        AuthorBlock(YES);
    }else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AuthorBlock(NO);
        });
    }
}

// 检测摄像头服务权限
+ (void)dc_CheckCameraAuthorization:(void (^)(BOOL isAuthorized))AuthorBlock
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (AVAuthorizationStatusAuthorized == authStatus) {
        //授权成功，执行后续操作
        AuthorBlock(YES);
    }else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AuthorBlock(NO);
        });
    }
}


// 检测麦克风服务权限
+ (void)dc_CheckMicrophoneAuthorization:(void (^)(BOOL isAuthorized))AuthorBlock
{
    AVAudioSessionRecordPermission authStatus = [[AVAudioSession sharedInstance] recordPermission];
    
    if (AVAudioSessionRecordPermissionGranted == authStatus) {
        //授权成功，执行后续操作
        AuthorBlock(YES);
    }else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AuthorBlock(NO);
        });
    }
}

@end
