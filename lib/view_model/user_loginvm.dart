import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sqlitetodo/helper/shared_pref.dart';
import 'package:sqlitetodo/pages/home/home_todo.dart';
import 'package:sqlitetodo/repository/auth_api.dart';

class AuthViewModel extends ChangeNotifier {
  void signIn(String username, String password, BuildContext context) async {
    var response = await AuthRepository.signIn(username, password);

    response.fold(
        (left) => {EasyLoading.showError(left)},
        (right) => {
              SharedPrefs.setToken("token_user", right.data["token"]),
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const HomePageNoVM()))
            });
  }
}
