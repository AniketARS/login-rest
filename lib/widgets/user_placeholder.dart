import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class UserPlaceholder extends StatefulWidget {
  final int index;
  final String name;
  final String email;
  final String avatar;
  final bool isFriend;

  const UserPlaceholder({
    super.key,
    required this.index,
    required this.name,
    required this.email,
    required this.avatar,
    required this.isFriend,
  });

  @override
  State<UserPlaceholder> createState() => _UserPlaceholderState();
}

class _UserPlaceholderState extends State<UserPlaceholder> {
  late bool _isFriend;

  @override
  void initState() {
    super.initState();
    _isFriend = widget.isFriend;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
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
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
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
            margin: const EdgeInsets.only(left: 5),
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
                  : const Icon(
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
