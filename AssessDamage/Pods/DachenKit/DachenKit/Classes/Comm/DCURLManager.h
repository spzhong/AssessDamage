//
//  DCURLManager.h
//  Pods
//
//  Created by 黄登登 on 2016/12/30.
//
//

#import <Foundation/Foundation.h>

#define CUSTOMHOSTSERVER          @"CustomHOSTSERVER"

#define HOSTSERVER_Net             @"https://xg.mediportal.com.cn" // 生产
#define HOSTSERVER_Fnt             @"https://pre.mediportal.com.cn" // 生产测试
#define HOSTSERVER_Test            @"https://test.mediportal.com.cn" // 测试
#define HOSTSERVER_TestHTTP        @"http://test.mediportal.com.cn" // 测试HTTP
#define HOSTSERVER_Dev             @"https://192.168.3.7" // 开发
#define HOSTSERVER_DevHTTP         @"http://192.168.3.7" // 开发HTTP
#define HOSTSERVER_Developer       @"http://192.168.3.63" // 后台测试

#define ShareURLManager [DCURLManager dc_shareManager]

#define HealthAddress(path) [ShareURLManager dc_pathForServer:1 methodPath:path]
#define IMAddress(path) [ShareURLManager dc_pathForServer:2 methodPath:path]
#define DrugAddress(path) [ShareURLManager dc_pathForServer:3 methodPath:path]
#define SocketAddress(path) [ShareURLManager dc_pathForServer:4 methodPath:path]
#define OrgAddress(path) [ShareURLManager dc_pathForServer:5 methodPath:path]
#define CommunityAddress(path) [ShareURLManager dc_pathForServer:6 methodPath:path]
#define CardsAddress(path) [ShareURLManager dc_pathForServer:7 methodPath:path]

/** 环境类型 */
typedef enum:NSInteger{
    emNetworkHostTypeOfTest = 1,             //测试环境(产品、测试用)
    emNetworkHostTypeOfKangeZhe = 2,         //生产环境(康`哲正式用)
    emNetworkHostTypeOfDev = 3,              //开发环境(开发用)
    emNetworkHostTypeOfFront = 4,            //生产调试环境(前置用)
    emNetworkHostTypeOfDeveloper = 5,        //后台调试环境(后台用)
    emNetworkHostTypeOfDevHTTP = 6,          //开发环境HTTP
    emNetworkHostTypeOfTestHTTP = 7,         //测试环境HTTP
}HostType;

/** 服务类型 */
typedef enum:NSInteger
{
    emServerTypeOfHealth = 1,
    emServerTypeOfIM = 2,
    emServerTypeOfDrug = 3,
    emServerTypeOfSocket = 4,
    emServerTypeOfOrg = 5,
    emServerTypeOfCommunity = 6,
    emServerTypeOfCards = 7
    
}ServerType;

@interface DCURLManager : NSObject

/** 环境类型 */
@property (nonatomic,assign)HostType hostType;
/** 主机地址 */
@property (nonatomic,readonly)NSString *hostAddress;
/** 主机端口号 */
@property (nonatomic,readonly)NSString *portName;
/** 展示名称 */
@property (nonatomic,readonly)NSString *showName;

+ (DCURLManager *)dc_shareManager;

- (NSArray *)dc_getHostNames;

- (NSString *)dc_pathForServer:(ServerType)serverType methodPath:(NSString *)path;

@end
