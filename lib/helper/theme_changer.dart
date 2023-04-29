import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/shared_repository.dart';

class ThemeNotifier extends ChangeNotifier {
  bool isDark = true;
  Future<void> getTheme() async {
    final shared = SharedManager<bool>();
    final value = await shared.read("theme_mode");
    isDark = value ?? false;
    notifyListeners();
  }

  Future<void> switchTheme() async {
    final shared = SharedManager<bool>();
    await shared.store("theme_mode", !isDark);
    isDark = !isDark;
    notifyListeners();
  }

  ThemeNotifier() {
    getTheme();
  }
}

final themeProvider = ChangeNotifierProvider((ref) {
  return ThemeNotifier();
});
