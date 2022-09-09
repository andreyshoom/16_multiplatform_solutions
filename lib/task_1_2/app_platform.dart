import 'dart:io';

import 'package:flutter/foundation.dart';

enum CustomPlatforms {
  andoid,
  ios,
  windows,
  web,
  linux,
  undefined,
}

class AppPlatform {
  static const Map<String, CustomPlatforms> _platformMap = {
    'android': CustomPlatforms.andoid,
    'ios': CustomPlatforms.ios,
    'windows': CustomPlatforms.windows,
    'web': CustomPlatforms.web,
    'linux': CustomPlatforms.linux,
  };

  static CustomPlatforms _getPlatform() {
    if (kIsWeb) {
      return CustomPlatforms.web;
    }
    return _platformMap[Platform.operatingSystem] ?? CustomPlatforms.undefined;
  }

  static CustomPlatforms get platform => _getPlatform();

  static bool get isMobile =>
      platform == CustomPlatforms.andoid || platform == CustomPlatforms.ios;
}
