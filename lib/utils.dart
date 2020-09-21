import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences appState;

Future<SharedPreferences> getAppState() async {
  sleep(Duration(microseconds: 2000));
  return await SharedPreferences.getInstance();
}
