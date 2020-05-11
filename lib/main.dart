import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statisticalcorona/provider/case_provider.dart';
import 'package:statisticalcorona/provider/detail_cases_provider.dart';
import 'package:statisticalcorona/provider/news_provider.dart';
import 'package:statisticalcorona/provider/theme_provider.dart';
import 'package:statisticalcorona/views/dashboard.dart';
import 'package:statisticalcorona/views/splash_screen.dart';
import 'package:statisticalcorona/widget/theme_button.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>CaseProvider()),
      ChangeNotifierProvider(create: (_)=>NewsProvider()),
      ChangeNotifierProvider(create: (_)=>DetailCasesProvider(),),
    ],
    child: MyApp(),
  ),
);

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