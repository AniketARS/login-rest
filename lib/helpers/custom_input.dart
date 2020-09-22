import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final IconData icondata;
  final String hint;
  final TextEditingController controller;
  bool isPassword;
  String pass;

  CustomInput(this.icondata, this.hint, this.controller,
      {this.isPassword: false, this.pass: 'notUsed'});

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  Color _borderColor = Colors.grey[400];

  @override
  void initState() {
    super.initState();
    if (widget.pass != 'notUsed')
      widget.controller.addListener(() {
        if (widget.controller.value.text == '')
          setState(() {
            _borderColor = Colors.grey[400];
          });
        else if (widget.controller.value.text != widget.pass)
          setState(() {
            _borderColor = Colors.red;
          });
        else if (widget.controller.value.text == widget.pass)
          setState(() {
            _borderColor = Colors.green;
          });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.pass == 'notUsed' ? Colors.grey[400] : _borderColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(width: 10),
          Icon(
            widget.icondata,
            size: 24,
            color: Theme.of(context).primaryColor.withOpacity(0.7),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.isPassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[500],
                ),
              ),
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
