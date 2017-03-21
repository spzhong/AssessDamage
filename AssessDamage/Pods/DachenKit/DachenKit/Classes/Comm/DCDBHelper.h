//
//  DCDBHelper.h
//  Pods
//
//  Created by 黄登登 on 2017/2/13.
//
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DCDBHelper : NSObject


@property(nonatomic,strong)FMDatabaseQueue  *dbIMBaseQueue;

+ (instancetype)dc_defaultDCDBHelper;
// 创建数据库
- (void)dc_createDataBase:(NSString *)dataBaseName;
// 获取数据库实例
- (FMDatabaseQueue *)dc_getDBQueue:(NSString *)dataBaseName;
// 创建数据库表结构
- (void)dc_createTableOnDB:(NSString *)dataBaseName;
// 升级数据库表结构
- (void)dc_upgrade;



@end
