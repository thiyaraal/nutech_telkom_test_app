import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/pop_up/flush_bar.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/base_url.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/helpers/app_routes.dart';

class RegistrationProvider with ChangeNotifier {
  final Dio dio = Dio();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> registrasiUser(BuildContext context, String email,
      String password, String firstName, String lastName) async {
    isLoading = true;
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
          validateStatus: (status) => status! < 500,
        ),
      );
      isLoading = false;

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        
        String successMessage = response.data['message'] ?? 'Berhasil registrasi, silahkan login';
        TopSnackBar.show(
          context: context,
          message: successMessage,
          backgroundColor: ColorStyle.success500,
        );
        Navigator.pushNamed(context, AppRoutes.login);
      } else {
        // Mengambil pesan error dari backend jika status code bukan 2xx
        String errorMessage = response.data['message'] ?? 'Gagal registrasi, silahkan coba lagi';
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: errorMessage,
        );
      }
    } catch (e) {
      isLoading = false;
      String errorMessage = 'Gagal registrasi, silahkan coba lagi';
      if (e is DioException && e.response != null) {
        // Mengambil pesan error spesifik dari backend jika tersedia
        errorMessage = e.response!.data['message'] ?? errorMessage;
      }
      TopSnackBar.show(
        context: context,
        message: errorMessage,
        backgroundColor: ColorStyle.warning500,
      );
    }
  }
}
