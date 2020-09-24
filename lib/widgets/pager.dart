import 'package:flutter/material.dart';

import '../utils.dart';

class Pager extends StatelessWidget {
  final Function() prev;
  final Function() next;
  Pager({this.prev, this.next});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PagerNavBtn(
            func: prev,
            type: 'prev',
            active: UserList.page > 1,
          ),
          PagerNavBtn(
            func: next,
            type: 'next',
            active: UserList.page < UserList.totalPages,
          ),
        ],
      ),
    );
  }
}

class PagerNavBtn extends StatelessWidget {
  final Function() func;
  final String type;
  final bool active;
  PagerNavBtn({this.func, this.type, this.active});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (active) func();
      },
      child: Row(
        children: [
          this.type == 'prev'
              ? Icon(
                  Icons.chevron_left,
                  size: 20,
                  color: active
                      ? Theme.of(context).primaryColor
                      : Colors.grey[400],
                )
              : SizedBox(width: 0),
          Text(
            this.type == 'prev' ? 'Prev' : 'Next',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w600,
              color: active ? Theme.of(context).primaryColor : Colors.grey[400],
            ),
          ),
          this.type == 'next'
              ? Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: active
                      ? Theme.of(context).primaryColor
                      : Colors.grey[400],
                )
              : SizedBox(width: 0),
        ],
      ),
    );
  }
}
