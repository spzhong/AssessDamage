//
//  DCDBHelper.m
//  Pods
//
//  Created by 黄登登 on 2017/2/13.
//
//

#import "DCDBHelper.h"
#import "DCFileHelper.h"

@interface DCDBHelper ()
{
    NSMutableDictionary *dbQueue;
}

@property(nonatomic,strong)NSMutableDictionary *dbQueueDict;

@end

@implementation DCDBHelper

+ (instancetype)dc_defaultDCDBHelper
{
    static DCDBHelper *DCDBHelper_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (DCDBHelper_ == nil) {
            DCDBHelper_ = [[self alloc] init];
        }
    });
    return DCDBHelper_;
}

- (id)init{
    self = [super init];
    if(self)
    {
        self.dbQueueDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    return self;
}

// 创建数据库
- (void)dc_createDataBase:(NSString *)dataBaseName{
    NSString *dbPath = [DCFileHelper dc_filepathAtRoot:[NSString stringWithFormat:@"%@.db",dataBaseName]];
    if(![DCFileHelper dc_targetExist:dbPath])
    {
        if (dataBaseName != nil && [self.dbQueueDict objectForKey:dataBaseName]) {
            return;
        }
        FMDatabaseQueue *dbBaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        [self.dbQueueDict setObject:dbBaseQueue forKey:dataBaseName];
    }
}

// 获取数据库实例
- (FMDatabaseQueue *)dc_getDBQueue:(NSString *)dataBaseName{
    
    if ([self.dbQueueDict objectForKey:dataBaseName]) {
        return [self.dbQueueDict objectForKey:dataBaseName];;
    }
}

// 创建数据库表结构
- (void)dc_createTableOnDB:(NSString *)dataBaseName{
}

// 升级数据库表结构
- (void)dc_upgrade {
}

- (void)DBinsertInto{
    
}

@end
