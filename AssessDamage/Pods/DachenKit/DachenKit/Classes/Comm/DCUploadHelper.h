//
//  DCUploadHelper.h
//  Pods
//
//  Created by 黄登登 on 2017/2/14.
//
//

#import <Foundation/Foundation.h>

// 七牛图片分析目录类型，有点乱，看下后台放哪里
typedef NS_ENUM(NSInteger, YMImageSaveType) {
    YMImageSaveTypeProfile,
    YMImageSaveTypeShare
};

typedef void(^DCUploadCompleteHandler)(BOOL success, id qiniuImgKeys, NSString *filePath);

@interface DCUploadHelper : NSObject

// 上传图片，支持UIImage、filePath类型，多张图片上传
// 默认要求压缩100k以下，长宽不超过960，压缩比0.45的jpg，默认上是YMImageSaveTypeShare
- (void)dc_uploadImage:(NSArray *)images
         completion:(DCUploadCompleteHandler)completion;

- (void)dc_uploadImage:(NSArray *)images
      imageSaveType:(YMImageSaveType)imageSaveType
         completion:(DCUploadCompleteHandler)completion;

- (void)dc_uploadImage:(NSArray *)images
 compressionQuality:(CGFloat)compressionQuality
           maxWidth:(CGFloat)maxWidth
          maxHeight:(CGFloat)maxHeight
      imageSaveType:(YMImageSaveType)imageSaveType
         completion:(DCUploadCompleteHandler)completion;

@end
