import 'package:flutter/material.dart';
import 'package:sqlitetodo/helper/shared_pref.dart';
import 'package:sqlitetodo/pages/auth/sign_in.dart';

class CheckTokenViewModel extends ChangeNotifier {
  void logout(BuildContext context) {
    SharedPrefs.clearByKey("token_user");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => SignInAuth()));
  }
}
