import 'package:flutter/material.dart';

import 'constants.dart';

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
        child: Text(text.toUpperCase()),
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
    Material(borderRadius: BorderRadius.circular(35.0),
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