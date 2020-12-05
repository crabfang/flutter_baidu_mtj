import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:baidu_mtj/baidu_mtj.dart';

void main() {
  const MethodChannel channel = MethodChannel('baidu_mtj');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await BaiduMtj.platformVersion, '42');
  });
}
