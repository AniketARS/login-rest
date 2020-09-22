import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_interactive/helpers/custom_input.dart';
import 'package:login_interactive/utils.dart';

class Login extends StatefulWidget {
  final PageController controller;
  Login(this.controller);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showProcess = false;
  TextEditingController _emailField;
  TextEditingController _passwordField;

  @override
  void initState() {
    super.initState();
    _emailField = TextEditingController();

    _passwordField = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailField.dispose();
    _passwordField.dispose();
  }

  var _formKey = GlobalKey<FormState>();

  _validateAndLogin() {
    var email = _emailField.value.text;
    var pass = _passwordField.value.text;

    if (email.contains('@reqres.in')) {
      String emailAdd = email.split('@')[0];
      if (emailAdd.contains('@')) {
        showSnackBar(context, 'Please enter valid email');
        return;
      }
      setState(() {
        _showProcess = true;
      });
      login(email, pass).then((res) {
        setState(() {
          _showProcess = false;
        });
        if (res.statusCode == 200) {
          showSnackBar(context, 'Logged in successfully');
        } else if (res.statusCode == 400) {
          showSnackBar(context, json.decode(res.body)['error']);
        }
      });
    } else {
      showSnackBar(context, 'Please enter valid email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30).subtract(
        EdgeInsets.only(bottom: 10),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            offset: Offset(0, 2),
            color: Colors.black38,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hello!',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                _showProcess
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      )
                    : SizedBox(width: 0),
              ],
            ),
            SizedBox(height: 20),
            CustomInput(Icons.email, 'Email', _emailField),
            SizedBox(height: 10),
            CustomInput(Icons.security, 'Password', _passwordField,
                isPassword: true),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                _validateAndLogin();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[100],
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
                Container(
                  height: 30,
                  width: 50,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                widget.controller.animateToPage(
                  1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'REGISTER',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 1.5,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
