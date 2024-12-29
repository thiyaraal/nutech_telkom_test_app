import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/base_url.dart';

class TransactionService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> transaction(
    String transactionCode,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await _dio.post(
        ApiURL.transaction,
        data: {"service_code": transactionCode},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer $token', // Use token from SharedPreferences
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
        return {"status": 1, "message": "Transaction failed"};
      }
    } on DioError catch (e) {
      return {
        "status": 1,
        "message": e.response?.data['message'] ?? 'Error occurred'
      };
    }
  }
}
