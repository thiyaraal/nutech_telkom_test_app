import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/pop_up/flush_bar.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/base_url.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/helpers/app_routes.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/helpers/shared+prefrences.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/profile_get_provider.dart';

class LoginProvider with ChangeNotifier {
  final Dio dio = Dio();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    isLoading = true;
    try {
      Response response = await dio.post(
        ApiURL.login,
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );
      isLoading = false;

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final token = response.data['data']['token'] ?? '';
        await UserPreferences.setToken(token); // Simpan token terlebih dahulu
        final profileProvider =
            Provider.of<ProfileProvider>(context, listen: false);
        await profileProvider.fetchProfile(); // Baru panggil fetchProfile

        String successMessage = response.data['message'] ?? 'Berhasil login';
        Navigator.pushNamed(context, AppRoutes.main);
        TopSnackBar.show(
          context: context,
          message: successMessage,
          backgroundColor: ColorStyle.success500,
        );
      } else {
        String errorMessage =
            response.data['message'] ?? 'Gagal login, silahkan coba lagi';
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: errorMessage,
        );
      }
    } catch (e) {
      print('Error saat login: $e');
      isLoading = false;
      String errorMessage = 'Gagal login, silahkan coba lagi';
      if (e is DioException && e.response != null) {
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
