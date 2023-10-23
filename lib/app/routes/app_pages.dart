import 'package:flutter/material.dart';

import '../ui/pages/home_page.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final Map<String, Widget Function(dynamic)> page = {
    AppRoute.home: (_) => const MyHomePage(),
  };
}
