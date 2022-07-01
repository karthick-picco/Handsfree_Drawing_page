
// ignore_for_file: prefer_final_fields, avoid_print
import 'drawing_page_platform_interface.dart';
import 'dart:async';

class DrawingPage {
  Future<String?> getPlatformVersion() {
    return DrawingPagePlatform.instance.getPlatformVersion();
  }
}




