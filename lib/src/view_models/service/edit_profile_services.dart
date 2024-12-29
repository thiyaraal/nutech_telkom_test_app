import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/base_url.dart';

class   EditProfileServices {
  // pakai token

  final Dio _dio = Dio();

  Future<void> editProfile(String firstName, String lastName) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await _dio.put(
        ApiURL.editProfile,
        data: {
          'first_name': firstName,
          'last_name': lastName,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
      } else {
        throw Exception('Failed to edit profile');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

}