import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:statisticalcorona/provider/case_provider.dart';
import 'package:statisticalcorona/provider/detail_cases_provider.dart';
import 'package:statisticalcorona/views/detail_cases.dart';
import 'package:statisticalcorona/widget/home/card_detail.dart';
import 'package:statisticalcorona/widget/home/card_info.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<CaseProvider>(context, listen: false).initcialCall();

  }

  @override
  Widget build(BuildContext context) {
    var data =     Provider.of<CaseProvider>(context, listen: false);
    final GlobalKey<AnimatedListState> _listKey = GlobalKey();

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          var casesProvider = Provider.of<CaseProvider>(context, listen: false);
          casesProvider.setLoadingStatus(true);
          await casesProvider.initcialCall();
        },
        child: SingleChildScrollView(
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
                            onChanged: (value){
                              data.searchCountries(value);
                              print(value);
                            },
                            decoration: InputDecoration(
                              hintText: "Search Country",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
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
                    builder: (BuildContext context, CaseProvider value,
                        Widget child) {
                      return value.isLoading
                          ? Center(child: JumpingDotsProgressIndicator(fontSize: 40.0,milliseconds: 9000))
                          : GridView.count(
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
                                  numberColors: Colors.red,
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
                  Consumer<CaseProvider>(
                    builder: (BuildContext context, CaseProvider value,
                        Widget child) {
                      if (value.isLoading == false) {

                      }
                      return value.isLoading
                          ? Center(child: JumpingDotsProgressIndicator(fontSize: 40.0,milliseconds: 9000,))
                          : AnimatedList( initialItemCount: value.arrCountries.length,shrinkWrap: true,key: _listKey,itemBuilder: (BuildContext context, int index, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: CardDetail(
                                critical: value.arrCountries[index].critical,
                                image: value
                                    .arrCountries[index].countryInfo.flag,
                                nameCountries:
                                value.arrCountries[index].country,
                                active: value.arrCountries[index].active,
                                recovered:
                                value.arrCountries[index].recovered,
                                deaths: value.arrCountries[index].deaths,
                                cases: value.arrCountries[index].cases
                                    .toDouble(),
                              ),
                            );
                      },);
                    },
                  ),
                ],
              ),
            ),
            padding: EdgeInsets.only(left: 20, right: 20),
          ),
        ),
      ),
    );
  }
}
