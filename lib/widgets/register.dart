import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_interactive/helpers/custom_input.dart';
import 'package:login_interactive/utils.dart';

class Register extends StatefulWidget {
  final PageController controller;
  const Register(this.controller, {super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Key _formKey = GlobalKey<FormState>();
  bool _showProcess = false;

  late TextEditingController _name;
  late TextEditingController _job;
  late TextEditingController _confirmPassword;
  late TextEditingController _passwordField;

  bool _generated = false;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _job = TextEditingController();
    _confirmPassword = TextEditingController();
    _passwordField = TextEditingController();
    _passwordField.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _job.dispose();
    _confirmPassword.dispose();
    _passwordField.dispose();
  }

  _validateAndRegister() {
    setState(() {
      _showProcess = true;
    });
    var name = _name.value.text;
    var job = _job.value.text;
    var pass = _passwordField.value.text;

    register('eve.holt@reqres.in', pass).then((value) {
      if (value.statusCode == 200) {
        setState(() {
          _showProcess = false;
        });
        appState?.setString('name', name);
        appState?.setString('job', job);
        appState?.setString('email', 'eve.holt@reqres.in');
        showSnackBar(context, 'Register Successfully');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _confirmPassword.addListener(() {
      _confirmPassword.buildTextSpan(
        style: const TextStyle(color: Colors.red),
        context: context,
        withComposing: false,
      );
    });
    return Container(
      padding: const EdgeInsets.all(30).subtract(
        const EdgeInsets.only(bottom: 10),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.65,
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
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      widget.controller
                          .animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    },
                    child: Icon(
                      Icons.chevron_left,
                      size: 35,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    'Register!',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w500,
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
              CustomInput(Icons.perm_identity, 'Name', _name),
              const SizedBox(height: 10),
              CustomInput(Icons.title, 'Job', _job),
              const SizedBox(height: 10),
              CustomInput(Icons.security, 'Password', _passwordField, isPassword: true),
              const SizedBox(height: 10),
              CustomInput(Icons.security, 'Confirm Password', _confirmPassword,
                  isPassword: true, pass: _passwordField.value.text),
              const SizedBox(height: 10),
              Container(
                height: 50,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      !_generated ? 'Generate your email' : 'eve.holt@reqres.in',
                      style: TextStyle(
                        color: _generated ? Colors.grey[600] : Colors.grey[400],
                        fontSize: _generated ? 16 : 14,
                        fontFamily: 'Quicksand',
                        fontWeight: _generated ? FontWeight.w800 : FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (!_generated) {
                          setState(() {
                            _generated = true;
                          });
                        } else {
                          Clipboard.setData(const ClipboardData(text: 'eve.holt@reqres.in'));
                          showSnackBar(context, 'Copied');
                        }
                      },
                      child: Text(
                        _generated ? 'Copy' : 'Generate',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  _validateAndRegister();
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
                        'Register',
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
            ],
          ),
        ),
      ),
    );
  }
}
