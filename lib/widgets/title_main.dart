import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../utils.dart';

class TitleMain extends StatelessWidget {
  final String title;
  final IconData? prefix;
  final bool isPrefix;
  final String bgColor;
  final Function()? logOutRef;
  const TitleMain({
    super.key,
    required this.title,
    required this.isPrefix,
    required this.prefix,
    required this.bgColor,
    required this.logOutRef,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              isPrefix
                  ? Transform.rotate(
                      angle: math.pi / 2,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          prefix,
                          size: 35,
                          color: bgColor == 'pink' ? Colors.grey[700] : Colors.grey[200],
                        ),
                      ),
                    )
                  : const SizedBox(
                      width: 0,
                    ),
              SizedBox(width: isPrefix ? 5 : 0),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 28,
                  height: 1.1,
                  fontWeight: FontWeight.w600,
                  color: bgColor == 'pink' ? Colors.grey[700] : Colors.grey[200],
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: loggedIn,
            builder: (context, value, child) {
              bool didLogged = appState?.getBool('logged_in') ?? false;
              if (value || didLogged) {
                return InkWell(
                  onTap: () {
                    logOut(context);
                    logOutRef!();
                  },
                  child: Icon(
                    Icons.exit_to_app,
                    size: 28,
                    color: Theme.of(context).primaryColor,
                  ),
                );
              } else {
                return const SizedBox(width: 0);
              }
            },
          ),
        ],
      ),
    );
  }
}
