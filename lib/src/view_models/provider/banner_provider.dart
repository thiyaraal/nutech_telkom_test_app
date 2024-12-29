import 'package:flutter/material.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/models/banner_model.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/service/banner_services.dart';

class BannerProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<DataBanner> _banners = [];
  List<DataBanner> get banners => _banners;
  final BannerServices _bannerServices = BannerServices();

  BannerProvider() {
   fetchBanners();
  }



  Future<void> fetchBanners() async {
    _isLoading = true;
    notifyListeners();
    try {
      BannerModel bannerModelData = await _bannerServices.getBanner();
      if (bannerModelData.data != null) {
        _banners = bannerModelData.data!;
      }
    } catch (e) {
      print("Error fetching banners: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
