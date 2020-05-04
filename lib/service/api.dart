
import 'package:dio/dio.dart';
import 'package:statisticalcorona/models/countries.dart';

class API {

  String urlDataTotalCases = 'https://corona.lmao.ninja/v2/all';
  String urlDataCountries = 'https://corona.lmao.ninja/v2/countries';
//
//  Future<List<Countries>> fetchData () async {
//    List<Countries> listCountries1 = [];
//    String url = 'https://corona.lmao.ninja/v2/all';
//    var dio = Dio();
//    var res = await dio.get(url);
//    if (res.statusCode == 200) {
//      var jsonData1 = res.data;
//      Countries countries
//      z= Countries(cases: jsonData1['cases'],
//          critical: jsonData1['critical'],
//          recovered: jsonData1['recovered'],
//          deaths: jsonData1['deaths'],
//
//        );
//      listCountries1.add(countries);
//
//    }
//
//    return listCountries1;
//  }


  Future<List<Countries>> fetchDataCountries () async {
      List<Countries> listCountries = [];
      String url = 'https://corona.lmao.ninja/v2/countries';
      var dio = Dio();
      var res = await dio.get(url);
      var jsonData = res.data;
      for(var i in jsonData){

        Countries countries = Countries(cases: i['cases'],
        critical: i['critical'],
        recovered: i['recovered'],
        deaths: i['deaths'],
        active: i['active'],
        countryInfo: CountryInfo(flag: i['countryInfo']['flag']),
        country: i['country'],);
        listCountries.add(countries);
      }

      return listCountries;
    }
}