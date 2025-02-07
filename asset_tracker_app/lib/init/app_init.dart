import 'package:flutter/material.dart';

final class AppInit {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
  }
}
