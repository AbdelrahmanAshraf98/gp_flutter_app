import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

void showToast({@required String msg, @required Color color}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget defaultButton({
  @required String text,
  @required Function function,
  double radius = 35.0,
  Color color = kPrimary,
}) =>
    Container(
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultTextField({
  @required TextEditingController controller,
  @required TextInputType type,
  @required String label,
  @required IconData prefix,
  bool isPassword = false,
  Function onSubmit,
  Function suffixPressed,
  IconData suffix,
  @required Function validation,
}) =>
    Material(
      borderRadius: BorderRadius.circular(35.0),
      elevation: 3,
      child: TextFormField(
        onFieldSubmitted: onSubmit,
        obscureText: isPassword,
        controller: controller,
        validator: validation,
        keyboardType: type,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(suffix),
                  onPressed: suffixPressed,
                )
              : null,
        ),
      ),
    );

navigateTo(Widget screen, context) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ));
navigateAndFinish(Widget screen, context) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ), (route) {
      return false;
    });

Widget drawerMenu(context)=>Column(
  children: [
    DrawerHeader(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('assets/images/pp.jpg'),
              ),
              SizedBox(height: 10.0,),
              Text(
                'Abd Elrahman Ashraf',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    ),
    ListTile(
      onTap: (){},
      leading: Icon(Icons.person),
      title: Text('Profile'),
    ),
    ListTile(
      onTap: (){},
      leading: Icon(Icons.medical_services),
      title: Text('My Medicines'),
    ),
    ListTile(
      onTap: (){},
      leading: Icon(Icons.device_thermostat),
      title: Text('My Records'),
    ),
    ListTile(
      onTap: (){},
      leading: Icon(Icons.chat),
      title: Text('Chat with doctor'),
    ),
    Spacer(),
    ListTile(
      onTap: (){},
      leading: Icon(Icons.logout),
      title: Text('Log Out'),
    ),
    SizedBox(height: 20.0,),
  ],
);
