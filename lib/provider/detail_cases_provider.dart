import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statisticalcorona/models/historical.dart';
import 'package:statisticalcorona/service/api.dart';

class DetailCasesProvider with ChangeNotifier{
  var api = API();
  List<Historical> array = [];
  Historical historical;

  Future fetchDataTimeLine(String countries) async{
    var dio = Dio();
    var res = await dio.get(api.urlHistoricalCountries);
    if (res.statusCode == 200 ) {
      Map<dynamic,dynamic> jsonData = res.data;

      jsonData.forEach((key, value) {// value is arraylist
        if (key == countries) {
            for(var i in value){
                array.add(Historical.fromJson(i));

            }
        }  else{

        }
      });

    }

  }


}