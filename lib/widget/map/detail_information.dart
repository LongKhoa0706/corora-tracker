import 'package:flutter/material.dart';

class DetailInfomation extends StatelessWidget {
  final int number;
  final String title;
  final List<Color> gradientColor;
  final IconData icon;
  final Color iconColors;

  const DetailInfomation({Key key, this.number, this.title, this.gradientColor, this.icon, this.iconColors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(begin:Alignment.topLeft,end: Alignment.topRight,colors: gradientColor
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            number.toString(),
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  title
              ),
              Icon(icon,
              color: iconColors,),
            ],
          )
        ],
      ),
    );

  }
}
