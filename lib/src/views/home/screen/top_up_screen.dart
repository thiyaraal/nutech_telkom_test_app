import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/button/custom_button_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/form_field/custom_form_widget.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/pop_up/flush_bar.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/pop_up/snackbar.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/font_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/balance_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/nominal_top_up_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/service/topup_services.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/widget/card_saldo.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/widget/nominal_top_up.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final TextEditingController _topUpController = TextEditingController();
  TopupServices topupServices = TopupServices();

  @override
  void initState() {
    super.initState();
    _topUpController.addListener(
      () {
        Provider.of<TopUpProvider>(context, listen: false).setNominal(
            _topUpController.text
                .replaceAll('.', '')); // Menyesuaikan format input
      },
    );
  }

  @override
  void dispose() {
    _topUpController.dispose();
    super.dispose();
  }

  bool isViewSaldo = false;
  @override
  Widget build(BuildContext context) {
    final topUpProvider = Provider.of<TopUpProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: null,
        automaticallyImplyLeading: false,
        title: Text(
          'Top Up',
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
              Text(
                'Silahkan masukkan',
                style: MyTextStyles.titleTextMedium.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 4),
              Text('nominal top up', style: MyTextStyles.titleTextMedium),
              const SizedBox(height: 40),
              CustomFormFieldText(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nominal tidak boleh kosong';
                  }
                  int parsedValue = int.tryParse(value.replaceAll('.', '')) ??
                      0; // Menghapus titik dan melakukan parsing
                  if (parsedValue < 10000) {
                    return 'Nominal minimal Rp 10.000';
                  } else if (parsedValue > 1000000) {
                    return 'Nominal maksimal Rp 1.000.000';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: _topUpController,
                hintText: 'Masukkan nominal top up',
                prefixIcon: const Icon(Icons.money),
                autovalidateMode: true,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 2.0,
                    childAspectRatio: 2,
                  ),
                  itemCount: topUpProvider.nominalValues.length,
                  itemBuilder: (context, index) {
                    return NominalTopUp(
                      nominalTopUp: topUpProvider.nominalValues[index],
                      onTap: (nominal) {
                        topUpProvider.setNominal(nominal);
                        _topUpController.text = nominal.replaceAll('.', '');
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer<TopUpProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButtonStyle(
              variant: provider.isLoading || !provider.isNominalValid
                  ? 'disabled'
                  : 'primary',
             textBUtton: provider.isLoading ? 'Sabar ya...' : 'Top Up',
              onPress: provider.isLoading || !provider.isNominalValid
                  ? (){}
                  : () {
                      if (provider.isNominalValid) {
                        provider.processTopUp(context);
                      } else {
                        TopSnackBar.show(
                          context: context,
                          message: 'Periksa kembali nominal yang diinput',
                          backgroundColor: Colors.red,
                          icon: Icons.error_outline,
                        );
                      }
                    },
            ),
          );
        },
      ),
    );
  }
}
