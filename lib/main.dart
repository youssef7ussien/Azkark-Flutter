import 'providers/categories_provider.dart';
import 'providers/sections_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home/home_page.dart';
import 'pages/home/loading_page.dart';
import 'providers/sebha_provider.dart';
import 'utilities/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SectionsProvider>(create: (context) => SectionsProvider()),
        ChangeNotifierProvider<CategoriesProvider>(create: (context) => CategoriesProvider()),
        ChangeNotifierProvider<SebhaProvider>(create: (context) => SebhaProvider()),
      ],
      child: Consumer<SectionsProvider>(
        builder: (context,sectionProvider,widget)
        {
          return MaterialApp(
            title: 'Azkark',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appTheme,
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: sectionProvider.isNewUser ?  FutureBuilder( 
                future: sectionProvider.tryToGetData(context),
                builder: (context,result){
                  if(result.connectionState==ConnectionState.waiting)
                  {
                    print(' The page is  Loading !!');
                    return LoadingPage();
                  }
                  else
                  {
                    print(' username is Youssef ');
                    return HomePage();
                  }
                },
              ) : HomePage(),
            ),
          ); 
        }
      ),
    );
  }
}