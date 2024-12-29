import 'package:flutter/foundation.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/models/services_model.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/service/service_services.dart';

class ServiceProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Assuming _services should be a list of Datum objects, not ServiceModel.
  List<DataService> _services = [];
  List<DataService> get services => _services;
  final ServiceServices _service = ServiceServices();

  ServiceProvider() {
    fetchServices();
  }

  Future<void> fetchServices() async {
    _isLoading = true;
    notifyListeners();

    try {
      ServiceModel servicesData = await _service.getService();
      if (servicesData.data != null) {
        _services = servicesData.data!;
      }
    } catch (e) {
      // Handle errors appropriately
      print("Error fetching services: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
