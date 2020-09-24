import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:math' as math;

class TitleMain extends StatelessWidget {
  final String title;
  final IconData prefix;
  bool isPrefix;
  final String bgColor;
  TitleMain({this.title, this.isPrefix, this.prefix, this.bgColor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
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
                          color: bgColor == 'pink'
                              ? Colors.grey[700]
                              : Colors.grey[200],
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 0,
                    ),
              SizedBox(width: isPrefix ? 5 : 0),
              Text(
                this.title,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 28,
                  height: 1.1,
                  fontWeight: FontWeight.w600,
                  color:
                      bgColor == 'pink' ? Colors.grey[700] : Colors.grey[200],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
