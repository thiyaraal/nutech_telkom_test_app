import 'package:dio/dio.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/base_url.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/models/profile_models.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/helpers/shared+prefrences.dart';

class ApiService {
  static final Dio _dio = Dio();

  static Future<Profile?> getProfile() async {
    try {
      final token = await UserPreferences.getToken();

      if (token == null) {
        throw Exception("Token tidak ditemukan. Harap login terlebih dahulu.");
      }

      // Kirim request ke API
      final response = await _dio.get(
        ApiURL.profile,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      // Periksa status response
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 0) {
          // Parse data profil dan kembalikan sebagai objek Profile
          return Profile.fromJson(data['data']);
        } else {
          throw Exception("Gagal mendapatkan profil: ${data['message']}");
        }
      } else {
        throw Exception("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error saat mengambil profil: $e");
      return null;
    }
  }
}
