import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  static const String downloadAndPlay = 'download_and_play';

  static Future<void> setDownloadAndPlay(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(downloadAndPlay, value);
  }

  static Future<bool> getDownloadAndPlay() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(downloadAndPlay) ?? false;
  }
}
