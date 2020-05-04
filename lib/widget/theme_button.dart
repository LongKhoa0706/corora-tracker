import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statisticalcorona/provider/theme_provider.dart';

class ThemeButton extends StatefulWidget {
  @override
  _ThemeButtonState createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    var themeObj = Provider.of<ThemeProvider>(context,listen: false);
    bool themeFlag = themeObj.isDarkTheme;
    String selectedItem = themeFlag ? "Dark" : "Light";
    return  DropdownButton<String>(
        value: selectedItem,
        underline: Container(),
        items: [
          DropdownMenuItem(
            child: Text(
              'Dark',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            value: 'Dark',
          ),
          DropdownMenuItem(
            child: Text(
              'Light',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            value: 'Light',
          )
        ],
        onChanged: (value) {
          setState(() {
            if (value == 'Dark' && selectedItem == 'Light' ||
                value == 'Light' && selectedItem == 'Dark') {
              themeObj.toggleTheme();
            }
            selectedItem = value;
          });
        });
  }
}
