import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sqlitetodo/dblite/db_sqlite.dart';
import 'package:sqlitetodo/models/todo_model.dart';

class DatabaseLiteViewModel extends ChangeNotifier {
  List<TodoModel> dataTodo = [];

  void loadDatabase() async {
    EasyLoading.show(status: 'loading...');

    dataTodo.clear();
    dataTodo.addAll(await DatabaseHelper.instance.queryAllRows());
    EasyLoading.dismiss();
    notifyListeners();
  }

  void insertDataDB(TodoModel todoModel) async {
    try {
      await DatabaseHelper.instance.insertByModel(todoModel).then((value) => {
            if (value > 0) {EasyLoading.showSuccess("Berhasil Input")}
          });
    } catch (err) {
      print("Error");
    }
  }
}
