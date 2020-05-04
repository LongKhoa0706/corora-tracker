import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:statisticalcorona/models/countries.dart';

class CaseProvider with ChangeNotifier{
  Countries countries;
  bool _isLoading = true;


  bool get isLoading => _isLoading;

  Future<Countries> fetchData () async {

    String url = 'https://corona.lmao.ninja/v2/all';
    var dio = Dio();
    var res = await dio.get(url);
    if (res.statusCode == 200) {
      var jsonData1 = res.data;
       countries = Countries.fromJson(jsonData1);
    }
    return countries;
  }



  Future initcialCall () async{
    await fetchData();
    _isLoading = false;
    notifyListeners();
  }


}