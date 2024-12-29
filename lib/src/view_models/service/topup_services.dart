import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/base_url.dart';

class TopupServices {
  final Dio _dio = Dio(); // Keep the Dio instance ready for use

  Future<Map<String, dynamic>> topup(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await _dio.post(
        ApiURL.topUp, // Ensure this is correctly defined
        data: {"top_up_amount": amount},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token', // Use token from SharedPreferences
          },
        ),
      );

      if (response.statusCode == 200) {
        return {
          "status": response.data['status'],
          "message": response.data['message'],
          "data": response.data['data']
        };
      } else {
        return {"status": 1, "message": "Failed to top up"};
      }
    } on DioException catch (e) {
      return {
        "status": 1,
        "message": e.response?.data['message'] ?? 'Error occurred'
      };
    }
  }
}
