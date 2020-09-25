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
  List<String> currentFriends;

  Widget _returnList(List<UserList> users) {
    currentFriends = appState.getStringList('friends') ?? [];
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add Friends',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w800,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(width: 10),
              Text(
                currentFriends.length.toString() + ' friends',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
        for (var user in users)
          UserPlaceholder(
            index: user.id,
            name: user.firstName + ' ' + user.lastName,
            email: user.email,
            avatar: user.avatar,
            isFriend: currentFriends.contains(user.id.toString()),
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
