import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sqlitetodo/models/user_model.dart';
import 'package:sqlitetodo/repository/user_api.dart';

class ProfileRandomViewModel extends ChangeNotifier {
  Results? dataProfile;

  void fetchProfile() async {
    try {
      EasyLoading.show(status: "Loading");
      dataProfile = await UserRepository.fetchUserData();

      notifyListeners();
    } catch (e) {
      EasyLoading.showError("Error");
    }
    EasyLoading.dismiss();
  }
}
