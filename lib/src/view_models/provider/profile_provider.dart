import 'package:flutter/material.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/service/edit_profile_services.dart';

class ProfileEditProvider extends ChangeNotifier {
  bool _isEditable = false;
  bool _isLoading = false;

  bool get isEditable => _isEditable;
  bool get isLoading => _isLoading;

  final EditProfileServices _editProfileServices = EditProfileServices();

  void toggleEdit() {
    _isEditable = !_isEditable;
    notifyListeners();
  }

  Future<void> saveChanges(String firstName, String lastName) async {
    if (firstName.isEmpty || lastName.isEmpty) {
      throw Exception('Nama depan dan belakang tidak boleh kosong.');
    }

    _isLoading = true;
    notifyListeners();

    try {
      debugPrint('Mengirim data: {firstName: $firstName, lastName: $lastName}');
      
      // Call the EditProfileServices to save changes
      await _editProfileServices.editProfile(firstName, lastName);

      // Exit edit mode after saving
      _isEditable = false;

      debugPrint('Profil berhasil disimpan');
    } catch (e) {
      debugPrint('Error saving profile: $e');
      rethrow; // Propagate error for UI to handle
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
