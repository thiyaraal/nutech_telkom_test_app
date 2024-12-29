
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/base_url.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/models/balance_model.dart';

class BalanceService {
  final Dio _dio = Dio();

  Future<BalanceResponse> getBalance() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception('Token is missing');
      }

      final response = await _dio.get(
        ApiURL.saldo,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json",
            

          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        print('saldo: ${response.data['data']['balance']}');
        return BalanceResponse.fromJson(response.data);
    
      } else {
        throw Exception('Failed to fetch balance');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}