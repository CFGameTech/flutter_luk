### luk小游戏sdk集成指南

本文为luk小游戏sdk在flutter项目中的集成指南文档，主要包括安卓端和iOS端

## 一、快速集成：

### 1.0、将luk sdk的依赖添加到您的flutter工程，具体为在[pubspec.yaml](pubspec.yaml#L23)文件下添加以下配置，注意添加的位置和缩进格式：

```yaml
  luk:
    git:
      url: 'https://github.com/CFGameTech/flutter_luk.git'
      ref: '1.0.7'
```

### 1.1、在Android设备上接入luk flutter sdk，还需要进行以下操作：

* （1）将[cfg_lib_v1.8.0.aar](android/app/libs/cfg_lib_v1.8.0.aar)复制到您的项目的对应路径下（您的flutter工程/android/app/libs）；
* (2)
  将原生部分需要的依赖添加依赖到Android工程的主模块（即app模块）的[build.gradle.kts](android/app/build.gradle.kts#44)：

```groovy

implementation(fileTree(mapOf("dir" to "libs", "include" to listOf("*.jar", "*.aar"))))

```

如果使用的不是kts，则参考如下配置：

```groovy

implementation fileTree(include: ["*.jar", "*.aar"], dir: 'libs')

```


经过以上几个步骤，在安卓设备上运行flutter项目所需要的依赖资源即可准备就绪，不同的环境（主要是flutter的版本、gradle插件的版本、实际项目的环境要求）可能有些许差别，此处仅供参考

## 二、主要业务流程：

### 2.1、sdk初始化:

```dart

Future setupSdk({required int appId, required String language, required String area, required bool isProduct});

```

其中：

| 参数名        | 类型      | 说明                   | 获取方式/可选值                        |
|------------|---------|----------------------|---------------------------------|
| `appId`    | int     | 接入方应用的唯一标识符（游戏/服务ID） | 联系平台对接人员获取（例如：`123456`）         |
| `language` | String  | 指定游戏内使用的语言           | 需使用预定义的多语言列表值                   |
| `area`     | String  | 指定正式服服务器区域           | 参考文档中的服务器区域划分                   |
| `product`  | boolean | 环境标识，决定是否连接生产环境      | `true`表示生产环境（正式服），`false`表示测试环境 |

>
语言和区域参考：[https://wiki.luk.live/docs/client-api/init](https://wiki.luk.live/docs/client-api/init)

调用示例(建议使用加上await关键字等待初始化逻辑调用完成)，参考[这里](lib/page/home_page.dart#L42)：

```dart

await Luk.instance.setupSdk(appId: 1013140, language: "zh_CN", area: "cn", isProduct: true);

```

### 2.2、设置监听sdk回调：

* sdk交互相关业务回调：参考[这里](lib/page/home_page.dart#L38)；
* sdk生命周期相关业务回调：参考[这里](lib/page/home_page.dart#L39)；
* sdk日志输出回调：参考[这里](lib/page/home_page.dart#L40)；

### 2.3、设置用户信息（用户登录）：

```dart

Future<bool> setUserInfo({required String uid, required String verifyCode});

```

调用示例参考[这里](lib/page/home_page.dart#L44)

```dart

bool _loginSuccess = await Luk.instance.setUserInfo(uid: "123456", verifyCode: "");
```

> 此处返回_loginSuccess为true则表示登录成功

### 2.4、加载游戏列表：

参考[这里](lib/page/home_page.dart#L47)，此时将能获取到游戏列表数据，用于后续的的展示以及调起小游戏界面；

### 2.5、展示游戏列表：

参考[这里](lib/page/home_page.dart#L82)
，UI界面可以参考示例的[GameListSheet](lib/sheet/game_list_sheet.dart)，也可以完全可以自己定义；

### 2.6、调起小游戏界面：

* 参考[GamePage](lib/page/game_page.dart)
* [LukGameView]()的用法参考[这里](lib/page/game_page.dart#L44),他需要一个[LukGameController](https://gitee.com/wys2018/luk_sdk/blob/master/lib/view/luk_game_controller.dart)
  ，用于控制游戏界面的生命周期流程；

### 2.7、关于[LukGameController](https://gitee.com/wys2018/luk_sdk/blob/master/lib/view/luk_game_controller.dart)

有以下几个关键方法：

* addOnGameChangedCallback：添加一个监听器
* removeOnGameChangedCallback：移除监听器
* loadGame：加载小游戏，需要小游戏的数据GameInfo
* onPause：小游戏最小化，或者是app切换到后台时调用；
* onResume：小游戏恢复到前台时按需调用；
* onDestroy：销毁游戏视图（不会调用其余业务逻辑）；
* onDispose：释放flutter资源

## 三、一些建议：

* 本flutter平台的sdk为Android以及iOS的原生sdk的flutter封装，原生sdk能提供的功能基本都能在flutter的版本得到支持；
* 遇到问题多参考Android以及iOS端的接入文档，文档地址：[https://wiki.luk.live/docs/introduce](https://wiki.luk.live/docs/introduce)；

