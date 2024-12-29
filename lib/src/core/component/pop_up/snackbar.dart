import 'package:flutter/material.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/font_style.dart';

class ShowDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const ShowDialogWidget({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: MyTextStyles.titleTextMedium.copyWith(
          color: ColorStyle.success500,
        )
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize:
              16, // Example style, replace with your own or pass as a parameter
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onConfirm,
          child: Text(
            'OK',
            style: MyTextStyles.titleTextRegular,
          ),
        ),
      ],
    );
  }
}
