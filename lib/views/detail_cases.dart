
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statisticalcorona/models/countries.dart';
import 'package:statisticalcorona/provider/detail_cases_provider.dart';
import 'package:statisticalcorona/widget/home/counter_detail.dart';

class DetailCases extends StatefulWidget {
  final String countries;
  final String urlImage;

  DetailCases(this.countries, this.urlImage);

  @override
  _DetailCasesState createState() => _DetailCasesState();
}

class _DetailCasesState extends State<DetailCases> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DetailCasesProvider>(context,listen: false).fetchDataTimeLine(widget.countries);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(widget.urlImage), fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      widget.countries,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Consumer<DetailCasesProvider>(
                builder: (BuildContext context, DetailCasesProvider value, Widget child) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: value.array.length,
                    itemBuilder: (_,index){
                      return Padding(
                        padding:  EdgeInsets.only(bottom: 15),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(4, 4),
                                blurRadius: 10,
                                color: Colors.grey.withOpacity(.2),
                              ),
                              BoxShadow(
                                offset: Offset(-3, 0),
                                blurRadius: 15,
                                color: Color(0xffb8bfce).withOpacity(.3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.calendar_today),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(value.array[index].date,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  CounterDetail(
                                    title: "Active",
                                    number: value.array[index].confirmed.toString(),
                                  ),
                                  CounterDetail(
                                    title: "Deaths",
                                    number: value.array[index].deaths.toString(),
                                  ),
                                  CounterDetail(
                                    title: "Recoverd",
                                    number: value.array[index].recovered.toString(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
