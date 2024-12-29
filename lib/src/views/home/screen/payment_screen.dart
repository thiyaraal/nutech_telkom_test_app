import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/button/custom_button_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/form_field/custom_form_widget.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/font_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/models/services_model.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/balance_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/transaction_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/widget/card_saldo.dart';

import '../../../view_models/service/transaction_service.dart';

class PaymentScreen extends StatefulWidget {
  final DataService? serviceData;
  const PaymentScreen({super.key, this.serviceData});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _tarifcontroller = TextEditingController();
  bool isViewSaldo = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    _tarifcontroller.text = widget.serviceData!.serviceTariff.toString();
  }

  @override
  void dispose() {
    _tarifcontroller.dispose(); // Don't forget to dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: Text(
          'Top Up Screen',
          style: MyTextStyles.titleTextMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<BalanceProvider>(
                builder: (context, balanceProvider, child) {
                  final balance = balanceProvider.balance ?? 0;
                  return CardSaldo(
                    isviewTextSaldo: false,
                    amount: balance.toString(),
                    initialVisibility: isViewSaldo,
                    onVisibilityChanged: (value) {
                      setState(() {
                        isViewSaldo = value;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 40),
              Text('Pembayaran',
                  style: MyTextStyles.titleTextMedium.copyWith(
                    fontWeight: FontWeight.w300,
                  )),
              const SizedBox(height: 20),
              Row(
                children: [
                  Image.network(
                    widget.serviceData!.serviceIcon.toString(),
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(width: 10),
                  Text(widget.serviceData!.serviceName.toString(),
                      style: MyTextStyles.titleTextMedium.copyWith(
                        fontSize: 18,
                      )),
                ],
              ),
              const SizedBox(height: 40),
              CustomFormFieldText(
                isEnabled: false,
                controller: _tarifcontroller,
                hintText: 'masukan pembayaran',
                prefixIcon: const Icon(Icons.money),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer<TransactionProvider>(
        builder: (context, provider, child) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomButtonStyle(
            variant: 'primary',
            onPress: () {
              if (!provider.isLoading && widget.serviceData != null) {
                provider.processPayment(
                    context, widget.serviceData!.serviceCode.toString());
              }
            },
            textBUtton: provider.isLoading ? 'sabar yaa...' : 'Bayar',
            
          ),
        ),
      ),
    );
  }
}
