import 'package:flutter/material.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/font_style.dart';
import 'package:intl/intl.dart';
class HistoryTransactions extends StatelessWidget {
  final String amount;
  final String originalDate;  // Rename to avoid conflict with formatted date
  final String originalTime;  // Rename to avoid conflict with formatted time
  final String description;
  final bool isIncome;

  const HistoryTransactions({
    super.key,
    required this.amount,
    required this.originalDate,
    required this.originalTime,
    required this.description,
    this.isIncome = true,
  });

  @override
  Widget build(BuildContext context) {
    // Format date and time using 'intl' package
    final date = DateFormat('dd MMMM yyyy').format(DateTime.parse(originalDate));
    final time = DateFormat('HH:mm').format(DateTime.parse(originalTime));

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: ColorStyle.neutral200),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        isIncome ? Icons.add : Icons.remove, // Dynamic icon based on income status
                        size: 20,
                        color: isIncome ? ColorStyle.success500 : ColorStyle.danger500,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Rp $amount',
                        style: MyTextStyles.titleTextLarge.copyWith(
                          color: isIncome ? ColorStyle.success500 : ColorStyle.danger500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          date,
                          style: MyTextStyles.regularText.copyWith(
                            color: ColorStyle.neutral300,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          time,
                          style: MyTextStyles.regularText.copyWith(
                            color: ColorStyle.neutral300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: MyTextStyles.mediumText.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
