import 'package:shared_preferences/shared_preferences.dart';

class SPref {
  static final SPref instance = SPref._internal();
  SPref._internal();
  Future set(String key, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  dynamic get(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? action = prefs.getString(key);
    return action;
  }
}
