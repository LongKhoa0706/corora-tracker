import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final double percen;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050), this.percen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                  color: color,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${percen.toStringAsFixed(2)}%',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          ),
        ],
      ),
    );
  }
}