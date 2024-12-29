import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/button/custom_button_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/form_field/custom_form_widget.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/font_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/helpers/app_routes.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: SingleChildScrollView(
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
                  'Masuk atau buat akun\nuntuk memulai',
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
                  height: 16,
                ),
                CustomFormFieldText(
                  isPassword: true,
                  controller: _passwordController,
                  hintText: 'Masukkan kata sandi anda',
                  prefixIcon: const Icon(
                    Icons.lock,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                CustomButtonStyle(
                  variant: 'primary',
                  textBUtton: 'Masuk',
                  onPress: () {
                    context.read<LoginProvider>().loginUser(
                          context,
                          _emailController.text,
                          _passwordController.text,
                        );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Belum punya akun? ',
                    style: MyTextStyles.regularText.copyWith(
                      color: ColorStyle.neutral300,
                    ),
                    children: [
                      TextSpan(
                        text: 'registrasi',
                        style: MyTextStyles.regularText.copyWith(
                          color: ColorStyle.neutral300,
                        ),
                      ),
                      TextSpan(
                        text: ' disini',
                        style: MyTextStyles.textButton.copyWith(
                          color: ColorStyle.brand500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.register,
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
