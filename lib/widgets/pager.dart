import 'package:flutter/material.dart';

import '../utils.dart';

class Pager extends StatelessWidget {
  final Function() prev;
  final Function() next;
  const Pager({super.key, required this.prev, required this.next});

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
  const PagerNavBtn({super.key, required this.func, required this.type, required this.active});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (active) func();
      },
      child: Row(
        children: [
          type == 'prev'
              ? Icon(
                  Icons.chevron_left,
                  size: 20,
                  color: active ? Theme.of(context).primaryColor : Colors.grey[400],
                )
              : const SizedBox(width: 0),
          Text(
            type == 'prev' ? 'Prev' : 'Next',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w600,
              color: active ? Theme.of(context).primaryColor : Colors.grey[400],
            ),
          ),
          type == 'next'
              ? Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: active ? Theme.of(context).primaryColor : Colors.grey[400],
                )
              : const SizedBox(width: 0),
        ],
      ),
    );
  }
}
