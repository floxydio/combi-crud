import 'package:flutter/material.dart';
import 'package:sqlitetodo/pages/auth/sign_in.dart';
import 'package:sqlitetodo/pages/home/home_todo.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePageNoVM(),
  ));
}
