# BDHelper

##### 1.在github上面创建自己项目


![B8DE34D6-6F9A-45DD-ADA1-85628A6F02EB.jpeg](http://upload-images.jianshu.io/upload_images/2107957-f38d3f38cc40954b.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/520)

##### 2.将项目clone到本地
``` 
1、$ git init 
```
``` 
2、$ git clone https://github.com/markStudy/BDHelper.git 
```

![2107957-fb8e738ea869368d.jpeg](http://upload-images.jianshu.io/upload_images/2107957-fb8e738ea869368d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/540)


##### 3. 给仓库创建个podspec文件
``` 
pod spec create **** 
```

##### 4.编写podspec文件

![2107957-0873736c148d90fd.jpeg](http://upload-images.jianshu.io/upload_images/2107957-0873736c148d90fd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/540)

**s.source_files** = ' ' 的多种写法

s.source_files = "BDHelper", "BDHelper/**/*.{h,m}"

表示**BDHelper/BDHelper/**目录下的所有 **.h** 和 **.m** 文件

s.source_files = 'BDHelper/**/*
表示**BDHelper/** 目录下所有文件，包括子目录下所有文件。 ```**/*```表示递归

当有多个文件时，应用,隔开

s.source_file  = 'MMDrawerController/MMDrawerController.{h,m}', 'MMDrawerController/UIViewController+MMDrawerController*'


##### 5.更新内容到git上面

##### 6.检查podspec文件
``` 
$ pod spec lint ***.podspec
```
验证可能出现的错误，把我遇到的一些问题, 单独写了出来.

* ###### swift版本未指定
```
Mark-Mac:BDHelper Mark_Mac$ pod lib lint LZTool.podspec

-> BDHelper (0.0.3)
[!] The validator for Swift projects uses Swift 3.0 by default, if you are using a different version of swift you can use a `.swift-version` file to set the version for your Pod. For example to use Swift 2.3, run: 
`echo "2.3" > .swift-version`.
```
解决方案：`echo 3.0 > .swift-version`

*  ###### fatal: Remote branch 0.0.1 not found in upstream origin

```
Mark-Mac:BDHelper Mark_Mac$ pod spec lint

-> BDHelper (0.0.1)
- ERROR | [iOS] unknown: Encountered an unknown error ([!] /usr/bin/git clone https://github.com/LQQZYY/PodTest.git /var/folders/14/95vmx0495_s5292ltvwpsc8h0000gn/T/d20170111-11240-1l3iq9n --template= --single-branch --depth 1 --branch 0.0.1

Cloning into '/var/folders/14/95vmx0495_s5292ltvwpsc8h0000gn/T/d20170111-11240-1l3iq9n'...
warning: Could not find remote branch 0.0.1 to clone.
fatal: Remote branch 0.0.1 not found in upstream origin
) during validation.

Analyzed 1 podspec.

[!] The spec did not pass validation, due to 1 error.
[!] The validator for Swift projects uses Swift 3.0 by default, if you are using a different version of swift you can use a `.swift-version` file to set the version for your Pod. For example to use Swift 2.3, run: 
`echo "2.3" > .swift-version`.
Mark-Mac:BDHelper Mark_Mac$
```
这是因为在你托管代码的库里(这里是指github)找不到这个分支, 也就是在编辑 **BDHelper.podspec**时, 里面的字段**s.verson**, **s.source** 中的 **tag**与**github**创建的**release**版本号不一致导致, 修改为一样即可!

*  ###### 如果还有警告，输入--allow-warnings

```
$ pod lib lint --allow-warnings
```


##### 7.发布自己的pods到CocoaPods trunk
使用CocoaPods trunk之前请确认CocoaPods版本是否是0.33或以上，打开Teaminal(终端)输入pod --version即可查看，如果版本过低，请执行sudo gem install cocoapods安装最新版本！

* 注册trunk
```
pod trunk register 邮箱地址 '用户名' --description='用户名'  --verbose
```
如果所有的步骤都能成功的话，你会受到一份邮件，需要点击验证下。

* 查看trunk
```
pod trunk me
```
可以查看你已经注册的信息，其中包含你的name、email、since、Pods、sessions，其中Pods为你往CocoaPods提交的所有的Pod！

* 添加其他维护者（如果你的pod是由多人维护的，你也可以添加其他维护者）
```
pod trunk add-owner '用户名' 邮箱地址
```

* 将你的库文件.podspec文件提交到公有的specs上面,成功后会出现Congrats信息噢~

``` 
$ pod trunk push 
```
* 如果还有警告，输入--allow-warnings
``` 
$ pod trunk push --allow-warnings
```

#####  8.Done

执行`pod install ` 命令

### 补充
这时候输入 pod search `***` ，你会发现可能搜索不到你刚刚上传的库
解决方案：删除~/Library/Caches/CocoaPods目录下的search_index.json文件
```
rm ~/Library/Caches/CocoaPods/search_index.json
```
* 删除成功后再执行pod search
* 输出：Creating search index for spec repo 'master'.. Done!，稍等片刻就会出现所有带`***`字段的类库出现。
