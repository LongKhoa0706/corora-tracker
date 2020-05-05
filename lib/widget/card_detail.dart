import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:statisticalcorona/widget/counter.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class CardDetail extends StatelessWidget {
  final String image;
  final int active;
  final int deaths;
  final double cases;
  final int critical;
  final int recovered;
  final String nameCountries;

  const CardDetail(
      {Key key,
      this.image,
      this.active,
      this.nameCountries,
      this.deaths,
      this.recovered,
      this.critical, @ required this.cases})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> section = List<PieChartSectionData>();

    PieChartSectionData _item1 = PieChartSectionData(
      color: Color(0xff8e61f3),
      value: active.toDouble(),
      title: "",
    );
    PieChartSectionData _item2 = PieChartSectionData(
      color: Color(0xffe84d86),
      title: "",
      value: deaths.toDouble(),
    );
    PieChartSectionData _item3 = PieChartSectionData(
      color: Color(0xff2ac386),
      title: "",
      value: recovered.toDouble(),
    );
    PieChartSectionData _item4 = PieChartSectionData(
      color: Color(0xffffdc8b),
      value: critical.toDouble(),
      title: "",
    );
    section = [_item1, _item2, _item3, _item4];
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: Colors.grey.withOpacity(.5),
            ),
            BoxShadow(
              offset: Offset(-3, 0),
              blurRadius: 15,
              color: Color(0xffb8bfce).withOpacity(.3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  nameCountries,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               Counter(
                 title: "Active",
                 detail: active,

                 numberColors: Color(0xff8e61f3),
               ),
                Counter(
                  title: "Deaths",
                  numberColors: Colors.red,
                  detail: deaths,
                ),
                Counter(
                  title: "Recoverd",
                  detail: recovered,
                  numberColors:Color(0xff2ac386),
                ),
                Counter(
                  title: "Critical",
                  numberColors:Color(0xffffdc8b),
                  detail: critical,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 230,
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(

                    child: PieChart(

                      PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,

                          borderData: FlBorderData(show: false),
                          sections: section),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(

                      children: <Widget>[
                        Indicator(
                          color: Color(0xff8e61f3),
                          text: 'Active',
                          percen: (active.toDouble() /(cases)  )*100,
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Color(0xffe84d86),
                          text: 'Deaths',
                          percen: (deaths.toDouble() /(cases)  )*100,
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Color(0xff2ac386),
                          text: 'Recoverd',
                          percen: (recovered.toDouble() / (cases)  )*100,
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Expanded(
                          child: Indicator(
                            color: Color(0xffffdc8b),
                            text: 'Critical',
                            percen: (critical.toDouble() / (cases) )*100,
                            isSquare: true,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
