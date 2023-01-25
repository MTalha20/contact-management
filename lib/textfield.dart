import 'package:flutter/material.dart';

Widget buildTextField(labeltext, controller){
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: TextField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: labeltext,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    ),
  );
}