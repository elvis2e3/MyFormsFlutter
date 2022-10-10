import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigController extends GetxController{
  var themeLight = ThemeData(
    primarySwatch: Colors.purple,
  ).obs;
  var themeDark = ThemeData(
    primarySwatch: Colors.purple,
    primaryColor: Colors.purple,
    textTheme: Typography.whiteCupertino,
    brightness: Brightness.dark,
    canvasColor: Colors.black87,
  ).obs;
  var theme = ThemeData(
    primarySwatch: Colors.purple,
  ).obs;
}