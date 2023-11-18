import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sqlitetodo/constant/url_config.dart';
import 'package:sqlitetodo/helper/shared_pref.dart';
import 'package:sqlitetodo/models/todo_api_model.dart';

class TodoRepository {
  Future<Either<String, List<DataTodo>>> getTodo() async {
    var dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    var response = await dio.get("${UrlConfig.baseURL}/v1/feed/get",
        options: Options(headers: {
          "x-access-token": await SharedPrefs.getToken("token_user")
        }));

    if (response.statusCode == 200) {
      return Right(TodoModel.fromJson(response.data).data!.toList());
    } else {
      return Left(response.data["message"]);
    }
  }

  Future<Either<String, Response>> createTodo(String title, String desc) async {
    var dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    var formData = {"title": title, "description": desc};
    var response = await dio.post("${UrlConfig.baseURL}/v1/feed/create",
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "x-access-token": await SharedPrefs.getToken("token_user")
            }));

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Right(response.data);
    } else {
      return Left(response.data["message"]);
    }
  }
}
