import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class CardInfo extends StatelessWidget {
  final int number;
  final String title;
  final Color numberColors;
  final List<Color> gradient;

  const CardInfo({Key key, this.number, this.title, this.numberColors, this.gradient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10,left: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: Colors.grey.withOpacity(.3),
            ),
            BoxShadow(
              offset: Offset(-3, 0),
              blurRadius: 15,
              color: Color(0xffb8bfce).withOpacity(.1),
            )
          ],
          gradient: LinearGradient(begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
          colors: gradient),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text(
              number.toString(),
              style: TextStyle(
                fontSize: 20,
                color: numberColors,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
