import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_interactive/helpers/custom_input.dart';
import 'package:login_interactive/utils.dart';

class Login extends StatefulWidget {
  final PageController controller;
  const Login(this.controller, {super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showProcess = false;
  late TextEditingController _emailField;
  late TextEditingController _passwordField;

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

  final _formKey = GlobalKey<FormState>();

  _validateAndLogin() {
    loggedIn.value = !loggedIn.value;
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
          appState?.setBool('logged_in', true);
          loggedIn.value = true;
          appState?.setString('email', email);
          appState?.setString('token', json.decode(res.body)['token']);
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
      padding: const EdgeInsets.all(30).subtract(
        const EdgeInsets.only(bottom: 10),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            blurRadius: 3,
            offset: Offset(0, 2),
            color: Colors.black38,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                          ),
                        )
                      : const SizedBox(width: 0),
                ],
              ),
              const SizedBox(height: 20),
              CustomInput(Icons.email, 'Email', _emailField),
              const SizedBox(height: 10),
              CustomInput(Icons.security, 'Password', _passwordField, isPassword: true),
              const SizedBox(height: 20),
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
                    margin: const EdgeInsets.symmetric(vertical: 20),
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
                    duration: const Duration(milliseconds: 300),
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
      ),
    );
  }
}
