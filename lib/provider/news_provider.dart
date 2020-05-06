
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:statisticalcorona/models/news.dart';
import 'package:statisticalcorona/service/api.dart';

class NewsProvider with ChangeNotifier {
  var apiNews = API();
  List<News> arrNews = [];
  
  Future getAllNews()  async {
    var dio = Dio();
    var res = await dio.get(API().urlNewsHealth);
    if (res.statusCode == 200) {
      var jsonData = res.data;
      jsonData['articles'].forEach((element){
          arrNews.add(News.fromJson(element));
      });
    }
    notifyListeners();
  }
}