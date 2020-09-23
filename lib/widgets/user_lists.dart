import 'package:flutter/material.dart';
import 'package:login_interactive/utils.dart';
import 'package:login_interactive/widgets/user_placeholder.dart';

class UserLists extends StatefulWidget {
  @override
  _UserListsState createState() => _UserListsState();
}

class _UserListsState extends State<UserLists> {
  ScrollController _scrollController;
  List<UserList> _users = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController
      ..addListener(() {
        var triggerToFetch = 0.7 * _scrollController.position.maxScrollExtent;
        if (_scrollController.position.pixels > triggerToFetch) {
          if (UserList.totalPages > UserList.page) {}
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchUsers(1),
      builder: (context, snapdata) {
        if (snapdata.hasData) {
          _users.addAll(snapdata.data);
          if (_users.length < 10) {
            fetchUsers(UserList.page + 1).then((value) {
              setState(() {
                _users.addAll(value);
              });
            });
          }
          return Expanded(
            child: ListView(
              controller: _scrollController,
              children: [
                for (var user in _users)
                  UserPlaceholder(
                    name: user.firstName + ' ' + user.lastName,
                    email: user.email,
                    avatar: user.avatar,
                  ),
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
