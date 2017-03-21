//
//  DCURLManager.m
//  Pods
//
//  Created by 黄登登 on 2016/12/30.
//
//

#import "DCURLManager.h"


static DCURLManager *urlManager = nil;

@implementation DCURLManager

+ (DCURLManager *)dc_shareManager
{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        urlManager = [NSKeyedUnarchiver unarchiveObjectWithFile:[DCURLManager encodingPath]];
        if(urlManager == nil)
        {
            urlManager = [[DCURLManager alloc] init];
            urlManager.hostType = emNetworkHostTypeOfKangeZhe;// 默认康哲正式
        }else{
            urlManager.hostType = urlManager.hostType;
        }
    });
    return urlManager;
}

#pragma mark - NSCoding

-(id)initWithWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        _hostType = [dict[@"hostType"] integerValue];
        _showName = dict[@"showName"];
        _portName = @"80";
        _hostAddress = HOSTSERVER_Net;
    }
    return  self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        _hostType = [aDecoder decodeIntegerForKey:@"hostType"];
        _showName=[aDecoder decodeObjectForKey:@"showName"];
        _portName = [aDecoder decodeObjectForKey:@"portName"];
        _hostAddress = [aDecoder decodeObjectForKey:@"hostAddress"];
    }
    return  self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:_hostType forKey:@"hostType"];
    [aCoder encodeObject:_showName forKey:@"showName"];
    [aCoder encodeObject:_portName forKey:@"portName"];
    [aCoder encodeObject:_hostAddress forKey:@"hostAddress"];
}

// 服务环境中文名称配置
- (NSArray *)dc_getHostNames
{
    NSArray *tempArray =@[@{@"hostType":@(emNetworkHostTypeOfDeveloper),@"showName":@"后台调试环境"},@{@"hostType":@(emNetworkHostTypeOfDev),@"showName":@"开发环境"},@{@"hostType":@(emNetworkHostTypeOfDevHTTP),@"showName":@"开发环境HTTP"},@{@"hostType":@(emNetworkHostTypeOfTest),@"showName":@"测试环境"},@{@"hostType":@(emNetworkHostTypeOfTestHTTP),@"showName":@"测试环境HTTP"},@{@"hostType":@(emNetworkHostTypeOfFront),@"showName":@"生产测试环境"},
                          @{@"hostType":@(emNetworkHostTypeOfKangeZhe),@"showName":@"生产环境"}];
    
    NSMutableArray *hostTypeArray = [[NSMutableArray alloc] initWithCapacity:[tempArray count]];
    
    [tempArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        DCURLManager *urlManager = [[DCURLManager alloc] initWithWithDict:dict];
        [hostTypeArray addObject:urlManager];
    }];
    
    return hostTypeArray;
}

// 获取设置的服务端中文名称
- (NSString *)getHostNameByHostType:(HostType)HostType
{
    NSString *hostName = @"";
    for(DCURLManager *urlManager in [self dc_getHostNames])
    {
        if(urlManager.hostType == HostType)
        {
            hostName = urlManager.showName;
            break;
        }
    }
    
    return hostName;
}

- (void)setHostType:(HostType)hostType
{
    switch (hostType) {
        case emNetworkHostTypeOfTest:
        {
            _hostAddress = HOSTSERVER_Test;
            _portName = @"80";
        }
            break;
        case emNetworkHostTypeOfKangeZhe:
        {
            _hostAddress = HOSTSERVER_Net;
            _portName = @"80";
        }
            break;
        case emNetworkHostTypeOfDev:
        {
            _hostAddress = HOSTSERVER_Dev;
            _portName = @"80";
        }
            break;
        case emNetworkHostTypeOfFront:
        {
            _hostAddress = HOSTSERVER_Fnt;
            _portName = @"80";
        }
            break;
        case emNetworkHostTypeOfTestHTTP:
        {
            _hostAddress = HOSTSERVER_TestHTTP;
            _portName = @"80";
        }
            break;
        case emNetworkHostTypeOfDevHTTP:
        {
            _hostAddress = HOSTSERVER_DevHTTP;
            _portName = @"80";
        }
            break;
        case emNetworkHostTypeOfDeveloper:
        {
            //自定义地址
            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:CUSTOMHOSTSERVER];
            if (str)
            {
                _hostAddress = str;
                _portName = @"80";
            }
            else
            {
                _hostAddress = HOSTSERVER_Developer;
                _portName = @"80";
            }
        }
            break;
            
        default:
        {
            _hostAddress = HOSTSERVER_Net;
            _portName = @"80";
        }
            break;
    }
    
    _showName = [self getHostNameByHostType:hostType];
    _hostType = hostType;
    
    [self save];
}

- (NSString *)dc_pathForServer:(ServerType)serverType methodPath:(NSString *)path
{
    NSMutableString *url = [NSMutableString stringWithString:self.hostAddress];
    switch (serverType) {
        case emServerTypeOfHealth:
            [url appendString:@"/health"];
            break;
        case emServerTypeOfIM:
            [url appendString:@"/"];
            break;
        case emServerTypeOfDrug:
            [url appendString:@"/drug"];
            break;
        case emServerTypeOfSocket:
            [url appendString:@"/im/websocket"];
            break;
        case emServerTypeOfOrg:
            [url appendString:@"/"];
            break;
        case emServerTypeOfCommunity:
            [url appendString:@"/community"];
            break;
        case emServerTypeOfCards:
            [url appendString:@"/cards"];
            break;
        default:
            break;
    }
    [url appendString:path];
    return url;
}

- (void)save
{
    [NSKeyedArchiver archiveRootObject:self toFile:[DCURLManager encodingPath]];

}

+ (NSString *)encodingPath
{
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"urlPath"];
    return path;
}

@end
