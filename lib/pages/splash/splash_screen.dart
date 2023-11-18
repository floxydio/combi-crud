import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqlitetodo/helper/shared_pref.dart';
import 'package:sqlitetodo/pages/auth/sign_in.dart';
import 'package:sqlitetodo/pages/home/home_todo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void onLoad() async {
    Future.delayed(Duration(seconds: 2), () async {
      var token = await SharedPrefs.getToken("token_user");

      if (token.isEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const SignInAuth()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePageNoVM()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Loading...")),
    );
  }
}
