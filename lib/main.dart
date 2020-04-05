import 'package:flutter/material.dart';
import 'pages/home/home_page.dart';
import 'utilities/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      title: 'Azkark',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: Directionality( // add this
        textDirection: TextDirection.rtl,
        child: HomePage()
      ),
    );
  }
}