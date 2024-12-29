import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/base_url.dart';

import 'package:sims_ppob_thiyara_al_mawaddah/src/models/services_model.dart';

class ServiceServices {
  final Dio _dio = Dio();

  Future<ServiceModel> getService() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception('Token is missing');
      }

      final response = await _dio.get(
        ApiURL.service,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        //tampilkan service semua list service
        print(
            'ServiceServices.getService() response.data: ${response.data}'
        );

        return ServiceModel.fromMap(response.data);
      } else {
        throw Exception('Failed to fetch service');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
