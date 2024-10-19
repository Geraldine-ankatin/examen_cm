import 'package:flutter/material.dart';

class InputDecortions {
  static InputDecoration authInputDecoration({
    required String hinText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blueGrey,
        )),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blueGrey,
          width: 3,
        )),
        hintText: hinText,
        hintStyle: const TextStyle(color: Colors.grey),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color:Colors.blueGrey,
              )
            : null);
  }
}
