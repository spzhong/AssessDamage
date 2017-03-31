# Group App->Server

估损 API_1.0版本

## 保持登录的状态 [/login]

### 登录 [POST]

+ Request  (application/json)

  {
  	"phone": "手机号",
  	"password": "登录密码"
  }

+ Response 200

```
{
	"code": "1",
	"msg":"提示信息",
	"data":{
		"userId":"用户的id",
		"token":"登录的token(默认是超时是7天)",
		"userName":"用户的名称",
		"userType":"用户类型（0是默认的保险估损人员，1是修来厂或4s店的修理员工）",
		"phone":"手机号",
		"enterpriseId":"所在企业id",
		"enterpriseName":"所在企业名称(子公司的名称，将来会有对应的公司数据表)",
		"cityId":"所在城市的id",
		"cityName":"所在城市的名称",
		"regionId":"负责区域的id",
  		"regionName":"负责区域的名称"
	},
}
```

# 


## 用户每次打开App时，进行调用自动登录的接口 [/{{cityId}/autoLogin]

### 自动登录 [POST]

+ Request  (application/json)


```
{
	"global":{
		"ver": "版本号",
      	"device": "设备信息",
      	"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
      	"token": "登录的token"
	},
}
```


- Response 200

code=1
```
{
	"code": "1",
	"msg":"提示信息",
	"data":"{用户信息}",
}
```

code=100
```
{
	"code": "100",
	"msg":"token已超时，请重新登录"
}
```


# 


## 获取短信 [/{{cityId}/forgetPassword]

### 忘记密码 [POST]

+ Request  (application/json)

```
{
	"global":{
		"ver": "版本号",
		"device": "设备信息",
		"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
		"token": "登录的token"
	},
	"phone": "手机号",
	"type":"默认为1，忘记密码"
}
```


- Response 200

code=1
```
{
	"code": "1",
	"msg":"短信验证码，已发送成功"
}
```


# 


## 修改密码 [/{{cityId}/forgetPassword]

### 修改登录密码 [POST]

+ Request  (application/json)

```
{
	"global":{
		"ver": "版本号",
		"device": "设备信息",
		"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
	},
	"phone": "手机号",
	"smsCode":"短信验证码",
	"password":"新的登录的密码"
}
```


- Response 200

code=1
```
{
"code": "1",
"msg":"登录密码已经修改成功，请重新登录"
}
```

​

## 估损单变化通知消息 [/{{cityId}/noticeInfo]

### 通知 [GET]

- Request  (application/json)

```
{
	"global":{
		"ver": "版本号",
		"device": "设备信息",
		"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
		"token": "登录的token",
	},
	"lastNoticeId":"App端最后一条的通知消息id(传空默认从头开始拉去数据)"
}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息",
	"data":[
		"title":"某某人已使用，分享出的六位码",
		"type":"0是别人领取了六位码，1是估损单发生了变化，2是估损单已提交审核，3是估损单审核失败，请重新编辑，4是估损单已结案..."
		"time":"时间戳",
		"reMark":"备注信息"
	],
}
```

# 



## 可修改估损单列表 [/{{cityId}/lostdamage/editList]

### 可修改估损单列表 [GET]

- Request  (application/json)

```
{
	"global":{
		"ver": "版本号",
		"device": "设备信息",
		"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
		"token": "登录的token"
    },

}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息",
	"data":[
		"lostdamageId":"估损单的id",
		"sixCode":"六位码",
		"time":"时间戳",
        "reMark":"备注信息",
		"overview":{//估损单的概要信息
			"car":"车型",
			"brand":"车型的品牌",
			"carNum":"车牌",
			"winCode":"win码",
			"repairDepotId":"修理厂id或4s店的id"
        },
	],
}
```

​

# 


## 历史估损单列表 [/{{cityId}/lostdamage/oldsList]

### 所有历史损单列表 [GET]

- Request  (application/json)

```
{
	"global":{
		"ver": "版本号",
		"device": "设备信息",
		"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
		"token": "登录的token"
	},
}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息",
	"data":[
		"lostdamageId":"估损单的id",
		"sixCode":"六位码",
		"time":"时间戳",
		"reMark":"备注信息",
		"status":"1是进行中，2是已提交审核，3是审核失败，4是已结案",
        "overview":{//估损单的概要信息
			"car":"车型",
          	"brand":"车型的品牌",
          	"carNum":"车牌",
		  	"winCode":"win码",
		  	"repairDepotId":"修理厂id或4s店的id"
		},
	],
}
```


# 


## 估损单修改记录 [/{{cityId}/lostdamage/editRecord]

### 估损单修改记录 [GET]

- Request  (application/json)

```
{
	"global":{
		"ver": "版本号",
		"device": "设备信息",
		"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
		"token": "登录的token",
	},
	"lostdamageId":"估损单的id"
}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息",
	"data":{
		"lostdamageId":"估损单的id",
		"sixCode":"当前六位码",
		"status":"1是进行中，2是已提交审核，3是审核失败，4是已结案",
		"overview":{//估损单的概要信息
			"car":"车型",
			"brand":"车型的品牌",
			"carNum":"车牌",
			"winCode":"win码",
			"repairDepotId":"修理厂id或4s店的id"
		},
		"editRecord":[//修改记录
			"sixCode":"六位码",
			"userId":"修改人id"
			"userName":"修改人",
			"title":"修改的信息，修改了工时"
			"reMark":"备注信息",
			"time":"时间戳，修改的时间",
		]
	}
}
```

# 


## 设置 [/{{cityId}/set/feedback]

### 意见反馈 [POST]

- Request  (application/json)

```
{
	"global":{
		"ver": "版本号",
        "device": "设备信息",
		"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
		"token": "登录的token",
	},
	"feedback":"反馈意见"
}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息"
}
```


# 


## 设置-检查版本更新 [/{{cityId}/set/checkVersion]

### 检查版本更新 [GET]

- Request  (application/json)

```
{
	"global":{
	"ver": "版本号",
		"device": "设备信息",
		"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
		"token": "登录的token",
	},
	"ver":"当前版本",
}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息"
}
```


# 


## 通过车型获取修理厂或保险公司 [/{{cityId}/config/repairDepots]

### 获取修理厂或保险公司 [GET]

- Request  (application/json)

```
{
	"global":{
		"ver": "版本号",
		"device": "设备信息",
		"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
		"token": "登录的token"
	}
}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息",
	"data":[
		"id":"修理厂或保险公司的编号",
		"name":"修理厂或保险公司的名称"
	]
}
```

# 


## 通知server，同步概要信息 [/{{cityId}/notice/syncSummary]

### 同步概要信息 [POST]

- Request  (application/json)

```
{
	"global":{
		"ver": "版本号",
		"device": "设备信息",
		"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
		"token": "登录的token",
	},
	"lostdamageId":"创建的估损单的id",
    "sixCode":"六位码",
	"time":"创建时间",
	"overview":{//估损单的概要信息
		"car":"车型",
		"brand":"车型的品牌",
		"carNum":"车牌",
		"winCode":"win码",
		"repairDepotId":"修理厂id或4s店的id"
	}
}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息"
}
```



# 


## 通知server，六位码已更新 [/{{cityId}/notice/syncSixCode]

### 通知后台更新六位码 [POST]

- Request  (application/json)

```
{
	"global":{
		"ver": "版本号",
		"device": "设备信息",
		"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
        "token": "登录的token",
	},
	"lostdamageId":"创建的估损单的id",
    "newSixCode":"新的六位码",
    "oldSixCode":"老的六位码",
}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息"
}
```






# 


## 通知server，同步修改估损单的信息，去拉去最新的估损单的修改记录 [/{{cityId}/notice/syncLostdamageInfo]

### 同步估损单信息 [POST]

- Request  (application/json)

```
{
	"global":{
		"ver": "版本号",
		"device": "设备信息",
		"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
		"token": "登录的token",
	},
	"lostdamageId":"估损单的id",
	"sixCode":"六位码",
}
```


- Response 200

```
{
	"code": "1",
    "msg":"提示信息"
}
```


# 


## 当前用户下，获取可分享的估损单列表 [/{{cityId}/lostdamage/share]

### 分享估损单列表 [POST]

- Request  (application/json)

```
{
	"global":{
		"ver": "版本号",
		"device": "设备信息",
		"userUUID": "用户设备UUID,用于区别当前用户所在的设备",
		"token": "登录的token"
	}
}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息",
	"data":[
		"lostdamageId":"估损单的id",
		"sixCode":"当前六位码",
		"status":"1是进行中，2是已提交审核，3是审核失败，4是已结案",
		"overview":{//估损单的概要信息
			"car":"车型",
			"brand":"车型的品牌",
			"carNum":"车牌",
			"winCode":"win码",
			"repairDepotId":"修理厂id或4s店的id"
		},
	]
}
```










# Group SdkServer->AppServer
##  


# 


## SDKServer向AppServer请求鉴权 [/{{cityId}/user/authentication]

### 鉴权接口 [POST]

- Request  (application/json)

```
{
	"encryption_token":"加密后的验证信息",
 	"userId":"用户的id",
	"lostdamageId":"估损单id",
	"sixCode":"估损单对应的当前的六位码",
}
```

- Response 200

```
{
	"code": "1",
	"msg":"鉴权成功"
}
```

# 


## SDKServer修改向AppServer发送变更信息 [/{{cityId}/lostdamage/exchange]

### 接收估损单变更信息 [POST]

- Request  (application/json)

```
	{
     "encryption_token":"加密后的验证信息",
	 "userId":"用户的id",
	 "lostdamageId":"估损单id",
	 "sixCode":"估损单对应的当前的六位码",
	 "overview":{//概要信息
		"car":"车型",
        "brand":"车型的品牌",
		"carNum":"车牌",
		"winCode":"win码",
		"repairDepotId":"修理厂id或4s店的id"
	},
	 "lostdamageInfo":{//估损单的信息
     	  
	 },
	 "exchangeData":[//变更信息
       	"type":"0是增加项目，1是修改项目，2是删除项目",
       	"title":"变更信息标题",
       	"reMark":"备注信息",
       	"time":"变更时间戳",
	 ]
}
```

- Response 200

```
{
	"code": "1",
	"msg":"回调信息"
}
```



# 


## SDKServer修改向AppServer已使用最新的六位码接口 [/{{cityId}/lostdamage/exchange]

### 六位码发生了变化 [POST]

- Request  (application/json)

```
{
     "encryption_token":"加密后的验证信息",
	 "userId":"用户的id",
	 "lostdamageId":"估损单id",
	 "newSixCode":"估损单对应的当前的六位码",
	 "oldSixCode":"老的六位码",
}
```

- Response 200

```
{
	"code": "1",
	"msg":"回调信息"
}
```

# 


## AppServer向SDKServer提供配置工时等数据  [/{{cityId}/config/data]

### 提供可查询的工时及相关数据接口 [POST]

- Request  (application/json)

```
{
	"encryption_token":"加密后的验证信息",
	"enterpriseId":"企业id(用于区分不同企业的工时算法，目前默认说的太保深圳分公司)，可以为空（查询所有的企业数据）"
}
```

- Response 200

```
{
	"code": "1",
	"msg":"回调信息",
	"data":[
      	"enterpriseId":"企业分公司的id",
      	"enterpriseName":"企业分公司的名称",
	]
}
```



# Group AppServer->SdkServer
##  

# 


## 获取所有估损单id列表 [/getALLlostdamageId]

### 获取所有的估损单id  [GET]

- Request  (application/json)

```
{
	"encryption_token":"加密后的验证信息",
	"lastLostdamageId":"最后一条的估损单的id",
}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息",
	"data":[
		"lostdamageId":"估损单的id",
		"sixCode":"当前可用的六位码",
	]
}
```


```
{
	"code": "100",
	"msg":"已经没有最新的估损单了,停止拉去数据吧"
}
```

# 


## 获取估损单修改记录，通过估损单的id或六位码 [/getLostdamageInfo]

### 获取估损单的历史修改记录  [GET]

- Request  (application/json)

```
{
	"encryption_token":"加密后的验证信息",
	"lostdamageId":"估损单的id",
	"sixCode":"六位码",
}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息",
	"data":[
		"lostdamageId":"估损单的id",
		"sixCode":"当前可用的六位码",
		"editRecord":[//修改记录
			"sixCode":"六位码",
			"userId":"修改人id"
			"userName":"修改人",
			"title":"修改的信息，修改了工时"
			"reMark":"备注信息",
			"time":"时间戳，修改的时间",
		]
	]
}
```
```
{
	"code": "100",
	"msg":"错误信息"
}
```

# 


## 获取估损单的完整信息，通过估损单的id或六位码 [/geteditRecord]

### 获取估损单的完整信息  [GET]

- Request  (application/json)

```
{
	"encryption_token":"加密后的验证信息",
	"lostdamageId":"估损单的id",
	"sixCode":"六位码",
}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息",
	"data":[
		"lostdamageId":"估损单的id",
		"sixCode":"当前可用的六位码",
		"time":"创建时间",
		"overview":{//估损单的概要信息
			"car":"车型",
			"brand":"车型的品牌",
			"carNum":"车牌",
			"winCode":"win码",
			"repairDepotId":"修理厂id或4s店的id"
		},
		"lostdamageInfo":{//估损单的信息
     	  	
	 	},
	]
}
```


# 


## 获取估损单id对应所有六位码 [/geteditRecord]

### 获取估损单id对应所有六位码  [GET]

- Request  (application/json)

```
{
	"encryption_token":"加密后的验证信息",
	"lostdamageId":"估损单的id"
}
```


- Response 200

```
{
	"code": "1",
	"msg":"提示信息",
	"data":{
		"lostdamageId":"估损单的id",
		"sixCode":"当前可用的六位码",
		"oldSixCodes":[//所有对应的六位码
			"sixCode":"六位码",
			"userToken":"对应的用户的token",
		]
	}
}
```

# Group App->SDK



## App调用SDK（初始化方法）

```
方法说明：App程序打开时，需要调用sdk初始化配置用户信息；
切换用户会重新调用初始化配置用户信息（sdk内部注意清除缓存）
```
```
/*
userId:用户ID
userType:用户类型（0是默认的保险估损人员，1是修来厂或4s店的修理员工）
enterpriseId:企业id(用于区分不同企业的工时算法，目前默认说的太保深圳分公司)
appDelagete:用来接收sdk内部的回调
*/
+(void)configUser:(NSString *)userId withUserType:(int)userType withEnterprise:(NSString *)enterpriseId withDelegate:(id<SDKCallBackDelegate>)appDelagete;	
```


## App调用SDK（创建估损单）

```
方法说明：block创建估损单的回调
创建估损单页面成功后，进行回调，app需要将信息同步到appServer上
```
```
/*
success:是否创建成功
lostdamageId:估损单的id
sixCode:六位码
overviewDic:{//估损单的概要信息
  	"car":"车型",
	"brand":"车型的品牌",
	"carNum":"车牌",
	"winCode":"win码",
	"repairDepotId":"修理厂id或4s店的id"
}
*/ 
+(void)creatLostdamage:(void (^)(BOOL success,NSString *lostdamageId,NSString *sixCode,NSMutableDictionary *overviewDic))block;	
```

## App调用SDK（修改估损单）

```
方法说明：block修改估损单的回调
修改估损单后成功后，进行回调，app需要通知appServer，拉去最新的估损单及修改记录
注意：sdk验证六位码后，sdk_server需要向app_server请求鉴权
```
```
/*
success:是否修改成功
lostdamageId:估损单的id
sixCode:六位码
*/ 
+(void)modifyLostdamage:(NSString *)sixCode withBlock:(void (^)(BOOL success,NSString *lostdamageId,NSString *sixCode))block;	
```

## App调用SDK（分享估损单）

```
方法说明：直接调用sdk内部的分享的页面
分享会产生新的六位码；成功后需要回调到App端;
注意：六位码变更后需要sdk_server通知app_server同步更新
```
```
/*
oldSixCode:六位码分享
lostdamageId:估损单的id
*/ 
+(void)shareLostdamage:(NSString *)oldSixCode with:(NSString *)lostdamageId withBlock:(void (^)(BOOL success,NSString *newSixCode))block;	
```

