//import 'dart:async';
//import 'package:flutter/services.dart' show rootBundle;
//import 'package:flutter/material.dart';
//import 'package:latlong/latlong.dart';
//import 'package:flutter_map/flutter_map.dart';
//import 'package:progress_indicators/progress_indicators.dart';
//import 'package:provider/provider.dart';
//import 'package:statisticalcorona/provider/case_provider.dart';
//
//class MapScreen extends StatefulWidget {
//  @override
//  _MapScreenState createState() => _MapScreenState();
//}
//
//class _MapScreenState extends State<MapScreen> {
//  String mapStyle;
//  List<Marker> listMarkers = [];
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    Provider.of<CaseProvider>(context, listen: false).fetchDataCountries();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Consumer<CaseProvider>(
//        builder: (BuildContext context, CaseProvider value, Widget child) {
//          for (var i in value.arrCountries) {
//            listMarkers.add(
//              Marker(
//                width: 15,
//                height: 15,
//                point: LatLng(i.countryInfo.lat * 1.0, i.countryInfo.long * 1.0),
//                builder: (ctx) => Container(
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(40),
//                      color: Colors.red[300].withOpacity(0.9)),
//                ),
//
//              ),
//            );
//          }
//          return value.isLoading ? Center(child: JumpingDotsProgressIndicator(fontSize: 40.0,)) : FlutterMap(
//            options: MapOptions(
//              zoom: 3.0,
//            ),
//            layers: [
//              TileLayerOptions(
//                urlTemplate:
//                "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
//                additionalOptions: {
//                  'accessToken':
//                  'pk.eyJ1IjoiYXNjdDk0IiwiYSI6ImNrOGt3d295eTAyNDYzc3Bzd2V0NDNnNDUifQ.GPmU-9qfK9xx0VtfPDTvHA',
//                  'id': 'mapbox.dark',
//                },
//              ),
//
//              MarkerLayerOptions(markers:  listMarkers),
//            ],
//          );
//        },
//      ),
//    );
//  }
//}
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:statisticalcorona/provider/case_provider.dart';
import 'package:statisticalcorona/provider/detail_cases_provider.dart';
import 'package:statisticalcorona/widget/map/detail_information.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String mapStyle;
    List<Marker> listMarkers = [];

  Completer<GoogleMapController> _controller = Completer();


  BitmapDescriptor pinLocationIcon;

  Future <BitmapDescriptor> _createMarkerImageFromAsset(String iconPath) async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(50,50)), iconPath);
    return pinLocationIcon;
  }
  final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(41.8558871, 61.4680761),
      zoom: 3.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      mapStyle = string;
    });
    Provider.of<CaseProvider>(context, listen: false).fetchDataCountries();
    _createMarkerImageFromAsset('assets/icon.png');
  }

 
  @override
  Widget build(BuildContext context) {
    Set<Marker> listMarker = Set();
    return Scaffold(
        body: Consumer<CaseProvider>(
          builder: (BuildContext context, CaseProvider value, Widget child) {
            for(var i in value.arrCountries){
              listMarker.add(
                Marker(
                    onTap: (){
                      _buildBottomSheet(i.countryInfo.flag,i.country,i.cases,i.active,i.recovered);
                    },
                  icon:   BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
                    markerId: MarkerId(i.country),
                  position: LatLng(i.countryInfo.lat*1.0, i.countryInfo.long*1.0),
                  infoWindow: InfoWindow(
                    title: i.country,
                    snippet: i.cases.toString()
                  )
                )
              );
            }
            return GoogleMap(
              markers: listMarker,
              initialCameraPosition: _kLake,
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(mapStyle);
                _controller.complete(controller);

              },
            );
          },
        ));
  }
  _buildBottomSheet(String image,String nameCountries,int cases,int active,int recovered) {
    return showDialog(context: context,builder: (_){
      return Dialog(
        backgroundColor: Colors.transparent,
        child:  Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
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
                borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: image.isEmpty? CircularProgressIndicator() : NetworkImage(image),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(nameCountries,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),),
                          cases > 4000 ? Text("In Danger", style:
                          TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),) : Text("Normal",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),)
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                          Text(cases.toString(),style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),),
                        Text("Tested"),
                      ],
                    ),

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DetailInfomation(
                      title: "Active",
                      number: cases,
                      gradientColor: [
                        Colors.redAccent[100],
                        Colors.redAccent,
                      ],
                      icon: Icons.trending_up,
                      iconColors: Colors.purple,
                    ),
                    DetailInfomation(
                      title: "Recoverd",
                      number: recovered,
                      gradientColor: [
                        Colors.green[400],
                        Colors.lightGreenAccent[100],
                      ],
                      icon: Icons.trending_down,
                      iconColors: Colors.greenAccent,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

}

