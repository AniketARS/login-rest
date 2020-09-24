import 'package:flutter/material.dart';
import 'package:login_interactive/utils.dart';
import 'package:login_interactive/widgets/pager.dart';
import 'package:login_interactive/widgets/user_placeholder.dart';

class UserLists extends StatefulWidget {
  @override
  _UserListsState createState() => _UserListsState();
}

class _UserListsState extends State<UserLists> {
  Future<List<UserList>> future;
  Widget mainWidget;

  Widget _returnList(List<UserList> users) {
    return ListView(
      children: [
        for (var user in users)
          UserPlaceholder(
            name: user.firstName + ' ' + user.lastName,
            email: user.email,
            avatar: user.avatar,
          ),
        Pager(
          prev: fetchPrev,
          next: fetchNext,
        ),
      ],
    );
  }

  @override
  void initState() {
    fetchUsers(1).then((value) {
      setState(() {
        mainWidget = _returnList(value);
      });
    });
    mainWidget = Center(child: CircularProgressIndicator());
    super.initState();
  }

  void fetchPrev() {
    setState(() {
      mainWidget = Center(child: CircularProgressIndicator());
      fetchUsers(UserList.page - 1).then((value) {
        setState(() {
          mainWidget = _returnList(value);
        });
      });
    });
  }

  void fetchNext() {
    setState(() {
      mainWidget = Center(child: CircularProgressIndicator());
      fetchUsers(UserList.page + 1).then((value) {
        setState(() {
          mainWidget = _returnList(value);
        });
      });
    });
  }

  printSomething() {
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: mainWidget);
  }
}
