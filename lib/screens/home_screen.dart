import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_interactive/widgets/no_user_found.dart';
import 'package:login_interactive/widgets/title_main.dart';
import 'package:path/path.dart';
import '../utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getAppState(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              appState = snapshot.data;
              if (!(appState.getBool('logged_in') ?? false)) {
                return Column(
                  children: [
                    TitleMain(
                      title: 'Hello, There',
                      isPrefix: false,
                      bgColor: 'pink',
                    ),
                    NoUserFound(),
                  ],
                );
              }
            }
            if (snapshot.hasError) {
              return Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[500],
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Something went wrong..'),
                      TextSpan(
                        text: '\n1.Try restarting app',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
