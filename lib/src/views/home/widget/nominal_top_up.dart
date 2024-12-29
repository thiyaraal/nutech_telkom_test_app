import 'package:flutter/material.dart';

import '../../../core/constant/font_style.dart';

class NominalTopUp extends StatelessWidget {
  final String nominalTopUp;
  //tidak require
  final void Function(String nominal) onTap;

  const NominalTopUp({
    super.key,
    required this.nominalTopUp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(nominalTopUp);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: 'Rp ',
                  style: MyTextStyles.mediumText,
                  children: [
                    TextSpan(
                      text: nominalTopUp,
                      style: MyTextStyles.mediumText,
                    ),
                  ],
                ),
              ),
            ),
          ),
          
        ),
      ),
    );
  }
}
