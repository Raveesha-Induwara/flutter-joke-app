import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  SharedPreferences? _prefs;

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveJokesData(List<Map<String, dynamic>> jokesData) async {
    List<String> encodedData = jokesData.map((joke) => jsonEncode(joke)).toList();
    _prefs?.setStringList('jokes-data', encodedData);
  }

  List<Map<String, dynamic>> getJokesData() {
    List<String>? encodedData = _prefs?.getStringList('jokes-data');
    if (encodedData != null) {
        return encodedData.map((jsonStr) => jsonDecode(jsonStr) as Map<String, dynamic>).toList();
    }
    return [];
  }

  void removePrefs() {
    _prefs?.remove('jokes-data');
  }
}