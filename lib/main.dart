import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_flutter_app/modules/login/login_screen.dart';
import 'package:gp_flutter_app/modules/medicine/medicine_screen.dart';
import 'package:gp_flutter_app/modules/register/register_screen.dart';
import 'package:gp_flutter_app/modules/welcome/welcome_screen.dart';

import 'modules/chat/chat_screen.dart';
import 'modules/medical_records/records_screen.dart';
import 'modules/profile/Profile_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GP',
      theme: ThemeData(
        primaryColor: Color(0xff00B0FF),
      ),
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}
