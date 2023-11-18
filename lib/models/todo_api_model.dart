class TodoModel {
  int? status;
  List<DataTodo>? data;
  String? message;
  bool? error;

  TodoModel({this.status, this.data, this.message, this.error});

  TodoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataTodo>[];
      json['data'].forEach((v) {
        data!.add(new DataTodo.fromJson(v));
      });
    }
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}

class DataTodo {
  int? id;
  String? title;
  String? description;
  bool? isChecked;

  DataTodo({this.id, this.title, this.description, this.isChecked});

  DataTodo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isChecked = json['is_checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['is_checked'] = this.isChecked;
    return data;
  }
}
