import 'package:dio/dio.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/base_url.dart';

Dio dio = Dio();

Future<Response> registrasiUser(
    String email, String password, String firstName, String lastName) async {
  try {
    Response response = await dio.post(
      ApiURL.register,
      data: {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
      },
      options: Options(
        validateStatus: (status) {
          return status! < 500;
        }
      )
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      print('Registration successful: ${response.data}');
      return response;
    } else {
      print('Registration failed with response: ${response.data}');
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: response.data
      );
    }
  } catch (e) {
    print('Registration encountered an error: $e');
    if (e is DioException) {
      throw e;
    } else {
      throw Exception('Failed to register with error: $e');
    }
  }
}
