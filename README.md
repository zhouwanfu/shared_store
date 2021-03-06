# shared_store

Native storage solution based on MMKV.

##  Example
#### iOS 
<div align=left> 
<img width="180" height="330" src="https://user-images.githubusercontent.com/68054922/156133619-de4c9235-aef0-452b-aa52-3c0552429392.png"/>
<img width="180" height="330" src="https://user-images.githubusercontent.com/68054922/156133622-bd4c3462-a8e8-45fc-9495-6fdada7b3c74.png"/>
<img width="180" height="330" src="https://user-images.githubusercontent.com/68054922/156133629-dcccb683-be33-457c-bb26-0fe2b8f8e748.png"/>
<img width="180" height="330" src="https://user-images.githubusercontent.com/68054922/156133634-69fc35c6-0123-4afb-8133-5440e5fb655a.png"/>
<img width="180" height="330" src="https://user-images.githubusercontent.com/68054922/156133639-ce04bfad-c852-435e-b7b1-7ce0f9c451c9.png"/>
</div>

#### Android
<div align=left> 
<img width="180" height="330" src="https://user-images.githubusercontent.com/68054922/156137697-08088572-5224-481a-89d4-2abb184cb9c7.png"/>
<img width="180" height="330" src="https://user-images.githubusercontent.com/68054922/156137705-f1b26b31-3267-41a9-9fed-8ee98f2f0648.png"/>
<img width="180" height="330" src="https://user-images.githubusercontent.com/68054922/156137708-acc515d0-47a0-43b1-b0e9-1290ff770b44.png"/>
<img width="180" height="330" src="https://user-images.githubusercontent.com/68054922/156137713-e134eb39-c727-477c-90ac-36f09a08afc9.png"/>
<img width="180" height="330" src="https://user-images.githubusercontent.com/68054922/156137717-4bfe4d12-0c73-4979-b6a4-eab8e9831636.png"/>
</div>


## Usage
### 一,Flutter端
1.添加依赖：

```dart
dependencies:
  flutter:
    sdk: flutter

  shared_store: ^0.01
```

2.启用SharedStore前，导入`shared_store_plugin.dart`对其进行初始化：

```dart
import 'package:shared_store/shared_store_plugin.dart';
```

```dart
SharedStorePlugin.initMMKV();
```

3.根据是否需要添加除内置默认的`default`MMKV外的可选的MMKV实例：
```dart
    String customMMKVId = "testPlugin";
    SharedStorePlugin.addMMKV(customMMKVId);
```

4.在需要存储数据时：
```dart
    const bool testBool = true;
    const int testInt = 123456;
    const double testDouble = 3.1415926;
    const String testString = 'testStringValue';
    String? boolResult = await SharedStorePlugin.storeBool('testBool', testBool);
    String? doubleResult = await SharedStorePlugin.storeDouble('testDouble', testDouble);
    String? intResult = await SharedStorePlugin.storeInt('testInt', testInt);
    String? stringResult = await SharedStorePlugin.storeString('testString', testString);
```

5.在需要读取数据时：
```dart
    bool? readBool = await SharedStorePlugin.readBool('testBool');
    int? readInt = await SharedStorePlugin.readInt('testInt');
    double? readDouble = await SharedStorePlugin.readDouble('testDouble');
    String? readString = await SharedStorePlugin.readString('testString');
```
6.在需要删除存储数据时：
```dart
SharedStorePlugin.removeValue('testBool');
```
