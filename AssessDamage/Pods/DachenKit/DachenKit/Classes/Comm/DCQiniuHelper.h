//
//  DCQiniuHelper.h
//  Pods
//
//  Created by 黄登登 on 2017/2/10.
//
//

#import <Foundation/Foundation.h>
#import "QiniuSDK.h"

typedef void (^DCQNUpCompletionHandler)(BOOL success, id responseObject, NSError *error);;
typedef void (^DCQNProgressCallBack)(NSString *key, float percent);
typedef void (^DCCallBackKey)(NSString *key);

typedef NS_ENUM(NSInteger ,qiNiuFileType){
    qiNiuTypeImage = 1,//图片
    qiNiuTypeVoice = 2,//语音
    qiNiuTypeVideo = 3,//视频
    qiNiuTypeDefault = 4 //其他
};

@interface DCQiniuHelper : NSObject

@property	(nonatomic,strong) QNUploadManager	*upManager;
@property	(nonatomic,assign) BOOL cancelled; //取消上传函数

+ (NSString *)uuidString;  //获取key  uuid

/**
 *七牛单获取服务器token方法
 *bucket为空间名
 */
- (void)dc_getQiniuTokenWithBucket:(NSString *)bucket
                      CallBack:(DCQNUpCompletionHandler)callBack;

/**
 *七牛通用调用方法  bucket为上传到七牛的对应空间
 *				 fileData为需要上传的文件data
 *				 fileType为需要上传的文件类型 （1代表图片  2代表语音  3代表视频 4其他）
 *		         qiniuToken为上传七牛所需token  可以根据上方法获取
 callBack为需要上传上传成功回调
 */
- (void)dc_qiNiuCommonlyWithBucket:(NSString *)bucket
                      withData:(NSData *)fileData
                      withType:(NSString *)fileType
                    qiniuToken:(NSString *)qiniuToken
                   qiniuDoMain:(NSString *)qiniuDoMain
                      callBack:(DCQNUpCompletionHandler)callBack;


/**
 *七牛上传获取上传进度方法  bucket为上传到七牛的对应空间
 *				 fileData为需要上传的文件data
 *				 fileType为需要上传的文件类型 （1代表图片  2代表语音  3代表视频 4其他）
 qiniuToken为上传七牛所需token  可以根据上方法获取
 *				 callBack为需要上传上传成功回调
 *				 progressCallBack为上传进度回调
 */
- (void)dc_qiuNiuUpWithProgressWithBucket:(NSString	*)bucket
                             fileData:(NSData *)fileData
                             fileType:(NSString	*)fileType
                           qiniuToken:(NSString *)qiniuToken
                          qiniuDoMain:(NSString *)qiniuDoMain
                             callBack:(DCQNUpCompletionHandler)callBack
                     progressCallBack:(DCQNProgressCallBack)progressCallBack;




@end
