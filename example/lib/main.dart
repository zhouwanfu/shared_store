import 'package:flutter/material.dart';
import 'package:shared_store/shared_store_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String result = '';
  @override
  void initState() {
    super.initState();
  }

  void initMMKV() {
    SharedStorePlugin.initMMKV();
    setState(() {
      result = 'init success';
    });
  }

  void addMMKV() {
    String customMMKVId = "testPlugin";
    SharedStorePlugin.addMMKV([customMMKVId]);
    setState(() {
      result = "MMKV $customMMKVId add success";
    });
  }

  void storeTestData() {
    const bool testBool = true;
    const int testInt = 123456;
    const double testDouble = 3.1415926;
    const String testString = 'testStringValue';
    SharedStorePlugin.storeBool('testBool', testBool);
    SharedStorePlugin.storeDouble('testDouble', testDouble);
    SharedStorePlugin.storeInt('testInt', testInt);
    SharedStorePlugin.storeString('testString', testString);
    setState(() {
      result =
          'store value : \n boolValue: $testBool \n intValue: $testInt \n doubleValue: $testDouble \n stringValue: $testString \n store value success';
    });
  }

  void readTestData() async {
    bool? readBool = await SharedStorePlugin.readBool('testBool');
    int? readInt = await SharedStorePlugin.readInt('testInt');
    double? readDouble = await SharedStorePlugin.readDouble('testDouble');
    String? readString = await SharedStorePlugin.readString('testString');
    setState(() {
      result =
          'read value : \n boolValue: $readBool \n intValue: $readInt \n doubleValue: $readDouble \n stringValue: $readString \n read value success';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SharedStore example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  CustomButton(
                      title: '1,initMMKV',
                      onTap: () {
                        initMMKV();
                      }),
                  Expanded(
                    child: Container(),
                  ),
                  CustomButton(title: '2,addMMKV', onTap: () => addMMKV())
                ],
              ),
              const Divider(
                height: 40,
                color: Colors.white,
              ),
              Row(
                children: [
                  CustomButton(title: '3,setData', onTap: () => storeTestData()),
                  Expanded(child: Container()),
                  CustomButton(title: '4,getData', onTap: () => readTestData())
                ],
              ),
              const Divider(
                height: 20,
                color: Colors.white,
              ),
              ConsolePage(consoleText: result),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.title, required this.onTap}) : super(key: key);
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(3.0, 3.0), blurRadius: 5.0, spreadRadius: 1.0),
              BoxShadow(color: Colors.grey, offset: Offset(-3.0, -3.0), blurRadius: 5.0, spreadRadius: 1.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(title)),
        ),
      ),
    );
  }
}

class ConsolePage extends StatelessWidget {
  const ConsolePage({Key? key, this.consoleText = ""}) : super(key: key);
  final String consoleText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: Colors.black, width: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(5),
            child: Text('console:'),
          ),
          Padding(padding: const EdgeInsets.all(10), child: Text(consoleText)),
        ],
      ),
    );
  }
}
