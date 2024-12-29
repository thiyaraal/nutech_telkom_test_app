import 'package:flutter/material.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';

class CardSaldo extends StatefulWidget {
  final String amount;
  final bool initialVisibility;
  final bool isviewTextSaldo;
  final TextStyle? titleStyle;
  final TextStyle? amountStyle;
  final Function(bool isVisible)? onVisibilityChanged;

  const CardSaldo({
    super.key,
    required this.amount,
    this.initialVisibility = false,
    this.isviewTextSaldo = true,
    this.titleStyle,
    this.amountStyle,
    this.onVisibilityChanged,
  });

  @override
  State<CardSaldo> createState() => _CardSaldoState();
}

class _CardSaldoState extends State<CardSaldo> {
  late bool isViewSaldo;

  @override
  void initState() {
    super.initState();
    isViewSaldo = widget.initialVisibility;
  }

  void _toggleVisibility() {
    setState(() {
      isViewSaldo = !isViewSaldo;
    });
    if (widget.onVisibilityChanged != null) {
      widget.onVisibilityChanged!(isViewSaldo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorStyle.brand600,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saldo Anda',
            style: widget.titleStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              text: 'Rp ',
              style: widget.amountStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(
                  text: widget.isviewTextSaldo
                      ? (isViewSaldo ? widget.amount : '*****')
                      : widget.amount,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (widget.isviewTextSaldo)
            Row(
              children: [
                Text(
                  isViewSaldo ? 'Sembunyikan saldo' : 'Lihat saldo',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: _toggleVisibility,
                  icon: Icon(
                    isViewSaldo ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
