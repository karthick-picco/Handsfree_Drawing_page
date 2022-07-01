import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'drawing_page_method_channel.dart';

abstract class DrawingPagePlatform extends PlatformInterface {
  /// Constructs a DrawingPagePlatform.
  DrawingPagePlatform() : super(token: _token);

  static final Object _token = Object();

  static DrawingPagePlatform _instance = MethodChannelDrawingPage();

  /// The default instance of [DrawingPagePlatform] to use.
  ///
  /// Defaults to [MethodChannelDrawingPage].
  static DrawingPagePlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DrawingPagePlatform] when
  /// they register themselves.
  static set instance(DrawingPagePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
