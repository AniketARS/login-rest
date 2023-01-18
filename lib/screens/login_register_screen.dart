import 'package:flutter/material.dart';
import 'package:login_interactive/widgets/login.dart';
import 'package:login_interactive/widgets/register.dart';
import 'package:login_interactive/widgets/title_main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PageController _controller = PageController(
    keepPage: false,
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ClipPath(
              clipper: MyCustomClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Column(
              children: [
                const TitleMain(
                  title: 'Please Login',
                  isPrefix: true,
                  prefix: Icons.chevron_right,
                  bgColor: 'white',
                  logOutRef: null,
                ),
                Expanded(
                  child: PageView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Align(alignment: Alignment.center, child: Login(_controller)),
                      Align(
                        alignment: Alignment.center,
                        child: Register(_controller),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var width = size.width;
    var height = size.height;

    Path path = Path()
      ..lineTo(0, height - 80)
      ..lineTo(width / 2, height)
      ..lineTo(width, height - 80)
      ..lineTo(width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
