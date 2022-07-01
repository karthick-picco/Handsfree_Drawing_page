import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'drawing_page_platform_interface.dart';

/// An implementation of [DrawingPagePlatform] that uses method channels.
class MethodChannelDrawingPage extends DrawingPagePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('drawing_page');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
