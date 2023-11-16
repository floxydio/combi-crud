import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  String? name;
  String? imageUrl;

  void onLoadImageandName() {
    name = "Dio Okta";
    imageUrl = "https://picsum.photos/200";

    print(imageUrl);
    notifyListeners();
  }
}
