import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlitetodo/pages/auth/sign_in.dart';
import 'package:sqlitetodo/pages/home/home_todo.dart';
import 'package:sqlitetodo/pages/navigator/nav.dart';
import 'package:sqlitetodo/view_model/dblite_vm.dart';
import 'package:sqlitetodo/view_model/profile_random_vm.dart';
import 'package:sqlitetodo/view_model/profile_vm.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseLiteViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileRandomViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        home: HomePageNoVM(),
      )));
}
