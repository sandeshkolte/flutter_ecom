import 'package:shared_preferences/shared_preferences.dart';

const _currentUid = "currentUid";

class SharedPref {
  void setUid(String uid) async {
    final pref = await SharedPreferences.getInstance();

    pref.setString(_currentUid, uid);
  }

  Future<String?> getUid() async {
    final pref = await SharedPreferences.getInstance();

    return pref.getString(_currentUid);
  }

  Future<bool> remove() async {
    final pref = await SharedPreferences.getInstance();

    return pref.clear();
  }
}
