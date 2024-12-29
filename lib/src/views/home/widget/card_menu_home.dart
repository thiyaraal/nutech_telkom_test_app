import 'package:flutter/material.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/font_style.dart';

class CardMenuHome extends StatelessWidget {
  final String imageMenu;
  final String titleMenu;
  final VoidCallback onTap;
  const CardMenuHome({super.key, required this.imageMenu, required this.titleMenu, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.network(
            imageMenu,
            width: 36,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            titleMenu,
            style: MyTextStyles.regularText.copyWith(
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
