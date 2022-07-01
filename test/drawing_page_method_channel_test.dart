import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drawing_page/drawing_page_method_channel.dart';

void main() {
  MethodChannelDrawingPage platform = MethodChannelDrawingPage();
  const MethodChannel channel = MethodChannel('drawing_page');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
