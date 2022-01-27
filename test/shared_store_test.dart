import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_store/shared_store_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('shared_store');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('int_test', () async {
    SharedStorePlugin.initMMKV();
    SharedStorePlugin.storeInt('test_int_key', 999);
    int? intResult = SharedStorePlugin.readInt('test_int_key');
    expect(intResult, 999);
  });

  test('double_test', () async {
    SharedStorePlugin.initMMKV();
    SharedStorePlugin.storeDouble('test_double_key', 3.1415926);
    double? intResult = SharedStorePlugin.readDouble('test_double_key');
    expect(intResult, 3.1415926);
  });

  test('string_test', () async {
    SharedStorePlugin.initMMKV();
    SharedStorePlugin.storeString('test_string_key', "string_value");
    String? intResult = SharedStorePlugin.readString('test_string_key');
    expect(intResult, 'string_value');

    test('bool_test', () async {
      SharedStorePlugin.initMMKV();
      SharedStorePlugin.storeBool('test_bool_key', true);
      bool? intResult = SharedStorePlugin.readBool('test_bool_key');
      expect(intResult, true);
    });
  });
}
