import 'package:flutter/material.dart';


class CounterDetail extends StatelessWidget {
  final String title;
  final String number;

  const CounterDetail({Key key, this.title, this.number}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
            title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            number,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}
