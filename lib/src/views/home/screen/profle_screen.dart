import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/button/custom_button_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/form_field/custom_form_widget.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/pop_up/flush_bar.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/font_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/helpers/app_routes.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/helpers/shared+prefrences.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/profile_get_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool _isSaving = false; // Track save operation loading state

  @override
  void initState() {
    super.initState();

    // Initialize controllers with current profile data
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    if (profileProvider.profile != null) {
      _firstNameController.text = profileProvider.profile!.firstName ?? '';
      _lastNameController.text = profileProvider.profile!.lastName ?? '';
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final profileEditProvider = Provider.of<ProfileEditProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: MyTextStyles.titleTextMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: profileProvider.isLoading || _isSaving
            ? Center(child: CircularProgressIndicator()) // Show loading during fetch or save
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/images/logo/profile_big.png'),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            profileProvider.fullName,
                            style: MyTextStyles.titleTextMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text('Email', style: MyTextStyles.titleTextSmall),
                    const SizedBox(height: 10),
                    CustomFormFieldText(
                      isEnabled: false,
                      hintText: profileProvider.profile?.email ?? '',
                      prefixIcon: const Icon(Icons.alternate_email),
                    ),
                    const SizedBox(height: 20),
                    Text('Nama depan', style: MyTextStyles.titleTextSmall),
                    const SizedBox(height: 10),
                    CustomFormFieldText(
                      isEnabled: profileEditProvider.isEditable,
                      controller: _firstNameController,
                      hintText: 'Nama depan',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 20),
                    Text('Nama belakang', style: MyTextStyles.titleTextSmall),
                    const SizedBox(height: 10),
                    CustomFormFieldText(
                      isEnabled: profileEditProvider.isEditable,
                      controller: _lastNameController,
                      hintText: 'Nama belakang',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 40),
                    Column(
                      children: [
                        CustomButtonStyle(
                          textBUtton: profileEditProvider.isEditable ? 'Simpan' : 'Edit Profile',
                          onPress: () async {
                            if (profileEditProvider.isEditable) {
                              setState(() {
                                _isSaving = true; // Set saving state
                              });

                              // Save changes and refresh profile
                              await profileEditProvider.saveChanges(
                                _firstNameController.text,
                                _lastNameController.text,
                              );
                              await profileProvider.fetchProfile();

                              setState(() {
                                _isSaving = false; // Reset saving state
                              });

                              TopSnackBar.show(
                                context: context,
                                message: 'Profile updated successfully!',
                                backgroundColor: ColorStyle.success500,
                              );
                            } else {
                              profileEditProvider.toggleEdit();
                            }
                          },
                          variant: profileEditProvider.isEditable ? 'primary' : 'outline',
                        ),
                        const SizedBox(height: 32),
                        CustomButtonStyle(
                          textBUtton: profileEditProvider.isEditable ? 'Batal' : 'Logout',
                          onPress: () async {
                            if (profileEditProvider.isEditable) {
                              profileEditProvider.toggleEdit();
                            } else {
                              await UserPreferences.clearPreferences();
                              Navigator.pushReplacementNamed(context, AppRoutes.login);
                              TopSnackBar.show(
                                context: context,
                                message: 'Berhasil logout',
                                backgroundColor: ColorStyle.success500,
                              );
                            }
                          },
                          variant: profileEditProvider.isEditable ? 'outline' : 'primary',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
