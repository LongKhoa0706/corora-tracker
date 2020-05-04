import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statisticalcorona/provider/case_provider.dart';
import 'package:statisticalcorona/service/api.dart';
import 'package:statisticalcorona/widget/card_detail.dart';
import 'package:statisticalcorona/widget/card_info.dart';
import 'package:statisticalcorona/models/countries.dart';
import 'package:statisticalcorona/widget/theme_button.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CaseProvider(),
      child: DashBoardWidget(),
    );
  }
}


class DashBoardWidget extends StatefulWidget {
  @override
  _DashBoardStateWidget createState() => _DashBoardStateWidget();
}

class _DashBoardStateWidget extends State<DashBoardWidget> {
  Future<List<Countries>> dataCountries;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CaseProvider>(context,listen: false).initcialCall();
    dataCountries = API().fetchDataCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 3),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Search Country",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 15,
                    ),
//                    Container(
//                      width: 50,
//                      height: 50,
//                      decoration: BoxDecoration(
//                        color: Colors.grey[500],
//                        boxShadow: [
//                          BoxShadow(
//                            color: Colors.white.withOpacity(.5),
//                            offset: Offset(5,5),
//
//                          )
//                        ],
//                        borderRadius: BorderRadius.circular(10),
//                      ),
//                      child: GestureDetector(
//                        onTap: (){
//                          setState(() {
//
//                             isOn = !isOn;
//                          });
//                        },
//                        child: isOn ?  Icon(
//                          Icons.wb_sunny,
//                          color: Colors.black,
//                        ): Icon(
//                          Icons.wb_sunny,
//                          color: Colors.white,
//                        ),
//                      )
//                    ),

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "World Update",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Consumer<CaseProvider>(
                  builder: (BuildContext context, CaseProvider value, Widget child) {
                    return value.isLoading ? CircularProgressIndicator() : GridView.count(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      crossAxisCount: 2,
                      children: <Widget>[
                        CardInfo(
                          number: value.countries.cases,
                          numberColors: Color(0xff8e61f3),
                          title: "infections",
                          gradient: [
                            Color(0xfff9f6fe),
                            Color(0xfffbfafe),
                          ],
                        ),
                        CardInfo(
                          number: value.countries.deaths,
                          numberColors: Color(0xffe84d86),
                          title: "deaths",
                          gradient: [
                            Color(0xfffef1f6),
                            Color(0xfffef6fa),
                          ],
                        ),
                        CardInfo(
                          number: value.countries.recovered,
                          numberColors: Color(0xff2ac386),
                          title: "recovered",
                          gradient: [
                            Color(0xffedf8ee),
                            Color(0xfff6fbf7),
                          ],
                        ),
                        CardInfo(
                          number: value.countries.critical,
                          numberColors: Color(0xffffdc8b),
                          title: "critical",
                          gradient: [
                            Color(0xfffff9ed),
                            Color(0xfffffbf4),
                          ],
                        ),
                      ],
                    );
                },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Most Infected",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                FutureBuilder(
                future: dataCountries,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Countries>arr = snapshot.data;
                    return ListView.builder(
                      itemCount: arr.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return CardDetail(
                          critical: arr[index].critical,
                          image: arr[index].countryInfo.flag,
                          nameCountries: arr[index].country,
                          active: arr[index].active,
                          recovered: arr[index].recovered,
                          deaths: arr[index].deaths,
                          cases: arr[index].cases.toDouble() ,
                        );
                    },);
                  }
                  return CircularProgressIndicator();
                },
                )
              ],
            ),
          ), padding: EdgeInsets.only(left: 20,right: 20),
        ),
      ),
    );
  }
}
