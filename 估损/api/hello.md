FORMAT: 1A

# 估损 API

1.0版本：创建估损API

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
    },
      "token": "登录的token"
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
    },
      "token": "登录的token",
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
    },
      "token": "登录的token"
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
  				"winCode":"win码"
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
    },
      "token": "登录的token"
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
  				"winCode":"win码"
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
    },
      "token": "登录的token",
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
  				"winCode":"win码"
        	},
        	"editRecord":[//修改记录
  	      		"sixCode":"六位码",
  				"userId":"修改人id"
  				"userName":"修改人",
  				"title":"修改的信息，修改了工时"
  				"reMark":"备注信息",
  				"time":"时间戳，修改的时间",
        	]
      },
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
    },
      "token": "登录的token",
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
    },
      "token": "登录的token",
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
    },
      "token": "登录的token"
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
    },
      "token": "登录的token",
      "lostdamageId":"创建的估损单的id",
      "sixCode":"六位码",
      "time":"创建时间",
      "overview":{//估损单的概要信息
  			"car":"车型",
  			"brand":"车型的品牌",
  			"carNum":"车牌",
  			"winCode":"win码"
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


## 通知server，同步修改估损单的信息，去拉去最新的估损单的修改记录 [/{{cityId}/notice/syncLostdamageInfo]

### 同步估损单信息 [POST]

- Request  (application/json)

  ```
    {
    "global":{
      "ver": "版本号",
      "device": "设备信息",
      "userUUID": "用户设备UUID,用于区别当前用户所在的设备",
    },
      "token": "登录的token",
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
    },
      "token": "登录的token"
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
  				"winCode":"win码"
        	},
      ]
    }
  ```


