import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {})],
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      drawer: Drawer(),
    );
  }
}
