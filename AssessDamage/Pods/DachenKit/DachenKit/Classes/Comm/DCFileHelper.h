//
//  DCFileHelper.h
//  Pods
//
//  Created by 黄登登 on 2017/2/13.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DCSubDirectoryType){
    DCSubDirectoryTypeHome,
    DCSubDirectoryTypeDocuments,
    DCSubDirectoryTypeTemp,
    DCSubDirectoryTypeCache,
};

@interface DCFileHelper : NSObject

+ (instancetype)dc_defaultDCFileHelper;

// 初始化APP的Root路径
+ (void)dc_initAPPRootPath;

//判断文件(夹)是否存在
+(BOOL)dc_targetExist:(NSString *)filepath;
+(void)dc_createFilepath:(NSString *)filepath;
//文件操作
+(NSString *)dc_filepathAtCaches:(NSString *)file;
+(NSString *)dc_filepathAtRoot:(NSString *)file;
+(NSString *)dc_filepathAtRes:(NSString *)file;
//获取文件夹内容列表
+(NSArray *)dc_filelistAtPath:(NSString *)filepath;
//文件管理
+(void)dc_deleteTargetAtPath:(NSString *)filepath;
+(void)dc_moveTargetAtPath:(NSString *)path1 toPath:(NSString *)path2;
+(void)dc_copyTargetAtPath:(NSString *)path1 toPath:(NSString *)path2;
//优先获取Documents资源
+(NSString *)dc_filepathAtDocOrRes:(NSString *)file;

// 建立子文件夹和文件路径
+ (NSString *)dc_setFilePathWithDirectoryType:(DCSubDirectoryType)subDirectoryType
                              subDirectory:(NSString *)subDirectory
                                  fileName:(NSString *)fileName
                             extensionType:(NSString *)extensionType;

// 异步保存图片到子文件夹
+ (void)dc_storeImageWithDirectoryType:(DCSubDirectoryType)directoryType
                              image:(id)image
                           fileName:(NSString *)fileName
                       subDirectory:(NSString *)subDirectory
                      extensionType:(NSString *)extensionType
                           callBack:(void (^)(BOOL success, NSString *filePath))callBack;

@end
