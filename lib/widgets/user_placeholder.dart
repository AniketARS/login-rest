import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class UserPlaceholder extends StatefulWidget {
  final int index;
  final String name;
  final String email;
  final String avatar;
  final bool isFriend;

  UserPlaceholder(
      {this.index, this.name, this.email, this.avatar, this.isFriend});

  @override
  _UserPlaceholderState createState() => _UserPlaceholderState(this.isFriend);
}

class _UserPlaceholderState extends State<UserPlaceholder> {
  bool _isFriend;
  _UserPlaceholderState(this._isFriend);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(0, 2),
            color: Colors.black26,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: widget.avatar,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        widget.email,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: InkWell(
              onTap: () {
                if (!_isFriend) {
                  addUserToFriend(context, widget.index);
                  setState(() {
                    _isFriend = true;
                  });
                }
              },
              child: !_isFriend
                  ? Icon(
                      Icons.add,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    )
                  : Icon(
                      Icons.done,
                      size: 28,
                      color: Colors.green,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
