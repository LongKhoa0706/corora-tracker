import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:statisticalcorona/models/countries.dart';
import 'package:statisticalcorona/service/api.dart';

class CaseProvider with ChangeNotifier{
  Countries countries;
  bool _isLoading = true;
  var api = API();
  List<Countries> arrCountries = [];


  bool get isLoading => _isLoading;
    void setLoadingStatus(bool status) {
      _isLoading = status;
      notifyListeners();
    }
    Future<Countries> fetchData () async {
    var dio = Dio();
    var res = await dio.get(api.urlDataTotalCases);
    if (res.statusCode == 200) {
      var jsonData1 = res.data;
       countries = Countries.fromJson(jsonData1);
    }
    return countries;
  }

  Future<List<Countries>> fetchDataCountries() async {
    var dio = Dio();
    var res = await dio.get(api.urlDataCountries);
    if (res.statusCode == 200) {
      List listDataCountries = res.data;
      listDataCountries.forEach((data)=>{
          arrCountries.add(Countries.fromJson(data)),
      });
    }
    return arrCountries;
  }
  Future initcialCall () async{
    await fetchData();
    await fetchDataCountries();
    _isLoading = false;
    notifyListeners();
  }


}