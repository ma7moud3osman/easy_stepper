// lib/src/core/platform_io.dart
import 'dart:io' show Platform;

/// Returns true if platform is Android or iOS
bool get isMobile => Platform.isAndroid || Platform.isIOS;

/// Returns false because this is not web
bool get isWeb => false;
