import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int detail;
  final Color numberColors;
  final String title;

  const Counter({Key key, this.detail, this.numberColors, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(title,
        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
        SizedBox(
          height: 10,
        ),
        Text(
          '${detail}',
          style: TextStyle(
            color: numberColors,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
