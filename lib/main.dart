import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_flutter_app/modules/login/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GP',
      theme: ThemeData(
        primaryColor: Color(0xff00B0FF),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: Color(0xff00B0FF),
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xff00B0FF),
            statusBarIconBrightness: Brightness.light,
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
