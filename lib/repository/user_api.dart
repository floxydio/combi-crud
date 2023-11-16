import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sqlitetodo/models/user_model.dart';

class UserRepository {
  static Future<Results> fetchUserData() async {
    var dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    var response = await dio.get("https://randomuser.me/api");
    var resbody = UserModel.fromJson(response.data);
    return resbody.results![0];
  }
}
