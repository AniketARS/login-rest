import 'package:flutter/material.dart';
import 'package:login_interactive/utils.dart';

class UserPlaceholder extends StatefulWidget {
  final String name;
  final String email;
  final String avatar;

  UserPlaceholder({this.name, this.email, this.avatar});

  @override
  _UserPlaceholderState createState() => _UserPlaceholderState();
}

class _UserPlaceholderState extends State<UserPlaceholder> {
  var _image = null;

  @override
  void initState() {
    super.initState();
    try {
      _image = Image.network(widget.avatar);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
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
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: ClipOval(child: _image),
              ),
              SizedBox(width: 20),
              Column(
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
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.add,
              size: 28,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
