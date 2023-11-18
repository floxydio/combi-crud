import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sqlitetodo/helper/shared_pref.dart';
import 'package:sqlitetodo/models/todo_api_model.dart';
import 'package:sqlitetodo/pages/auth/sign_in.dart';
import 'package:sqlitetodo/repository/todo_api.dart';

class TodoViewModel extends ChangeNotifier {
  List<DataTodo> dataTodo = [];

  void fetchTodo() async {
    var response = await TodoRepository().getTodo();

    response.fold((l) => {EasyLoading.showError(l)},
        (r) => {dataTodo.clear(), dataTodo.addAll(r)});

    notifyListeners();
  }

  void createTodo({required String title, required String desc, required VoidCallback onFailed}) async {
    var response = await TodoRepository().createTodo(title, desc);

    response.fold(
        (l) => {
              if (l == "User Unauthorized")
                {SharedPrefs.clearByKey("token_user"), onFailed()}
              else
                {EasyLoading.showError(l)}
            },
        (r) => {EasyLoading.showSuccess("Success Input")});
    notifyListeners();
  }
}
