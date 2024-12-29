import 'package:flutter/material.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/models/profile_models.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/service/profile_sevices.dart';

class ProfileProvider with ChangeNotifier {

  
  Profile? _profile;
  bool _isLoading = false;
  Profile? get profile => _profile;
  bool get isLoading => _isLoading;
  String get fullName =>
      "${_profile?.firstName ?? ''} ${_profile?.lastName ?? ''}";

   ProfileProvider() {
    fetchProfile();
  }
  Future<void> fetchProfile() async {
    _isLoading = true;
    notifyListeners();

  

    final profileData = await ApiService.getProfile();
    if (profileData != null) {
      _profile = profileData;
    } else {
      _profile = null;
    }
    _isLoading = false;
    notifyListeners();
  }

}
