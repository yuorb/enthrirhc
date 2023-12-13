import 'dart:io' as io;
import 'package:flutter/foundation.dart';

enum Platform {
  android,
  webDesktop,
  webMobile,
  windows,
  linux,
  unadapted;

  static Platform get() {
    if (kIsWeb) {
      if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android) {
        return Platform.webMobile;
      } else {
        return Platform.webDesktop;
      }
    }
    if (io.Platform.isAndroid) {
      return Platform.android;
    }
    if (io.Platform.isWindows) {
      return Platform.windows;
    }
    if (io.Platform.isLinux) {
      return Platform.linux;
    }
    return Platform.unadapted;
  }
}
