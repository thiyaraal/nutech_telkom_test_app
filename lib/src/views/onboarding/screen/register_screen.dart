import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/button/custom_button_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/form_field/custom_form_widget.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/pop_up/flush_bar.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/font_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/helpers/app_routes.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/registarsi_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/service/registrasi_service.dart';

class RegisterSCreen extends StatefulWidget {
  const RegisterSCreen({super.key});

  @override
  State<RegisterSCreen> createState() => _RegisterSCreenState();
}

class _RegisterSCreenState extends State<RegisterSCreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _createPasswordController =
      TextEditingController();
  final TextEditingController _confrimPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo/Logo.png',
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'SIMS PPOB',
                      style: MyTextStyles.titleTextLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Lengkapi data untuk\nmembuat akun',
                  style: MyTextStyles.titleTextLarge,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomFormFieldText(
                  controller: _emailController,
                  hintText: 'masukkan email anda',
                  prefixIcon: const Icon(
                    Icons.alternate_email,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormFieldText(
                  controller: _firstNameController,
                  hintText: 'Nama depan',
                  prefixIcon: const Icon(
                    Icons.person,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormFieldText(
                  controller: _lastNameController,
                  hintText: 'Nama belakang',
                  prefixIcon: const Icon(
                    Icons.person,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormFieldText(
                  controller: _createPasswordController,
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  isPassword: true,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormFieldText(
                  controller: _confrimPasswordController,
                  hintText: 'Konfirmasi Password',
                  prefixIcon: const Icon(Icons.lock),
                  isPassword: true,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 100,
                ),
                CustomButtonStyle(
                  variant: 'primary',
                  textBUtton: 'Registrasi',
                  onPress: () async {
                    if (_createPasswordController.text ==
                        _confrimPasswordController.text
                        ) {
                      context.read<RegistrationProvider>().registrasiUser(
                            context,
                            _emailController.text,
                            _createPasswordController.text,
                            _firstNameController.text,
                            _lastNameController.text,
                          );
                    } else {
                     TopSnackBar.show(
                        context: context,
                        message: 'Password tidak sama',
                        backgroundColor: ColorStyle.warning500,
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Sudah punya akun?login ',
                    style: MyTextStyles.regularText.copyWith(
                      color: ColorStyle.neutral300,
                    ),
                    children: [
                      TextSpan(
                        text: ' disini',
                        style: MyTextStyles.textButton.copyWith(
                          color: ColorStyle.brand500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.login,
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
