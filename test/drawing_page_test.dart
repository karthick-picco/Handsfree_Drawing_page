import 'package:flutter_test/flutter_test.dart';
import 'package:drawing_page/drawing_page.dart';
import 'package:drawing_page/drawing_page_platform_interface.dart';
import 'package:drawing_page/drawing_page_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDrawingPagePlatform 
    with MockPlatformInterfaceMixin
    implements DrawingPagePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DrawingPagePlatform initialPlatform = DrawingPagePlatform.instance;

  test('$MethodChannelDrawingPage is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDrawingPage>());
  });

  test('getPlatformVersion', () async {
    DrawingPage drawingPagePlugin = DrawingPage();
    MockDrawingPagePlatform fakePlatform = MockDrawingPagePlatform();
    DrawingPagePlatform.instance = fakePlatform;
  
    expect(await drawingPagePlugin.getPlatformVersion(), '42');
  });
}
