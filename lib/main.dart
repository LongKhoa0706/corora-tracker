import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statisticalcorona/provider/theme_provider.dart';
import 'package:statisticalcorona/views/dashboard.dart';
import 'package:statisticalcorona/widget/theme_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter",
      home: DashBoard(),
    );
  }
}