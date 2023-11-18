import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sqlitetodo/constant/url_config.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepository {
  static Future<Either<String, Response>> signIn(
      String username, String password) async {
    var dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    var formData = {"username": username, "password": password};

    var response = await dio.post("${UrlConfig.baseURL}/v1/signin",
        data: formData,
        options: Options(
            validateStatus: (status) {
              return status! < 500;
            },
            followRedirects: false,
            headers: {"Content-Type": "application/x-www-form-urlencoded"}));
    if (response.statusCode == 200) {
      return Right(response);
    } else {
      return Left(response.data["message"]);
    }
  }
}
