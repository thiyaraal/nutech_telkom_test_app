import 'package:flutter/material.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/font_style.dart';

class CustomButtonStyle extends StatelessWidget {
  final String textBUtton;
  final Function() onPress;
  final String variant;
  final ButtonStyle? buttonStyle;

  const CustomButtonStyle({
    super.key,
    this.buttonStyle,
    required this.textBUtton,
    required this.onPress,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    Color textColor;
    Color borderColor;

    // Menentukan warna berdasarkan varian
    switch (variant) {
      case 'primary':
        buttonColor = ColorStyle.brand600;
        textColor = Colors.white;
        borderColor = Colors.transparent;
        break;
      case 'disabled':
        buttonColor = ColorStyle.neutral200;
        textColor = Colors.white;
        borderColor = Colors.transparent;
        break;
      case 'secondary':
        buttonColor = ColorStyle.brand600;
        textColor = ColorStyle.neutral200;
        borderColor = Colors.transparent;
        break;
      case 'outline':
        buttonColor = Colors.white;
        textColor = ColorStyle.brand600; // Warna teks sesuai tema
        borderColor = ColorStyle.brand600; // Border warna sesuai tema
        break;
      default:
        buttonColor = ColorStyle.brand600;
        textColor = Colors.white;
        borderColor = Colors.transparent;
    }

    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onPress,
        style: buttonStyle ??
            ElevatedButton.styleFrom(
              minimumSize: const Size(
                double.infinity,
                56,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: borderColor,
                  width: variant == 'outline' ? 2 : 0, // Tambahkan border untuk outline
                ),
              ),
            ),
        child: Text(
          textBUtton,
          style: MyTextStyles.textButton.copyWith(color: textColor),
        ),
      ),
    );
  }
}
