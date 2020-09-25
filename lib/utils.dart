import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

ValueNotifier loggedIn = ValueNotifier(false);
ValueNotifier currentPage = ValueNotifier(1);

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

class UserList {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  static int page;
  static int perPage;
  static int total;
  static int totalPages;

  UserList({this.id, this.email, this.firstName, this.lastName, this.avatar});

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        avatar: json['avatar']);
  }
}

Future<List<UserList>> fetchUsers(int i) async {
  final http.Response response =
      await http.get('https://reqres.in/api/users?page=' + i.toString());

  if (response.statusCode == 200) {
    List<UserList> users = [];
    var data = json.decode(response.body);
    UserList.page = data['page'];
    UserList.perPage = data['per_page'];
    UserList.total = data['total'];
    UserList.totalPages = data['total_pages'];
    for (var v in data['data']) {
      users.add(UserList.fromJson(v));
    }
    return users;
  } else {
    throw Exception('Something went wrong');
  }
}

void addUserToFriend(BuildContext context, int index) {
  var currentFriends = appState.getStringList('friends') ?? <String>[];
  currentFriends.add(index.toString());
  appState.setStringList('friends', currentFriends).then((value) {
    showSnackBar(context, "Added to friends");
  });
}

void logOut(BuildContext context) {
  appState.setBool('logged_in', false);
  loggedIn.value = false;
  showSnackBar(context, 'Logged Out Successfully');
}
