import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

SharedPreferences appState;

Future<SharedPreferences> getAppState() async {
  sleep(Duration(microseconds: 2000));
  return await SharedPreferences.getInstance();
}

void showSnackBar(BuildContext context, String title) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(title),
  ));
}

Future<http.Response> login(String email, String pass) async {
  final http.Response response = await http.post(
    'https://reqres.in/api/login',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        "email": email,
        "password": pass,
      },
    ),
  );
  return response;
}

Future<http.Response> register(String email, String pass) async {
  final http.Response response = await http.post(
    'https://reqres.in/api/login',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        "email": email,
        "password": pass,
      },
    ),
  );
  return response;
}
