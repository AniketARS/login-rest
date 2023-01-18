import 'package:flutter/material.dart';
import 'package:login_interactive/widgets/no_user_found.dart';
import 'package:login_interactive/widgets/title_main.dart';
import 'package:login_interactive/widgets/user_lists.dart';

import '../utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    loggedIn = ValueNotifier(false);
  }

  void refresh() {
    setState(() {});
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
              bool doesLogged = appState?.getBool('logged_in') ?? false;
              return ValueListenableBuilder(
                valueListenable: loggedIn,
                builder: (context, value, child) {
                  if (value || doesLogged) {
                    return Column(
                      children: [
                        TitleMain(
                          title: 'Hello, ${appState?.getString('name') ?? 'There'}',
                          isPrefix: false,
                          bgColor: 'pink',
                          logOutRef: refresh,
                          prefix: Icons.menu,
                        ),
                        const UserLists(),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        const TitleMain(
                          title: 'Hello, There ',
                          isPrefix: false,
                          bgColor: 'pink',
                          logOutRef: null,
                          prefix: null,
                        ),
                        NoUserFound(),
                      ],
                    );
                  }
                },
              );
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
                    children: const <TextSpan>[
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
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
