import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/component/pop_up/snackbar.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/balance_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/service/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  bool isLoading = false;

  void processPayment(BuildContext context, String serviceCode) async {
    if (serviceCode.isEmpty) {
      print('Service code is invalid');
      return;
    }

    isLoading = true;
    notifyListeners();

    TransactionService transactionService = TransactionService();
    Map<String, dynamic> response = await transactionService.transaction(serviceCode);

    isLoading = false;
    notifyListeners();

    if (response['status'] == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShowDialogWidget(
        title: 'Pembayaran Berhasil',
        content: 'Kamu berhasil melakukan pembayaran untuk layanan ${response['data']['service_name']}',
        onConfirm: () {
          Navigator.of(context).pop();
          fetchAndUpdateBalance(context);
        },
      );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Payment Error'),
            content: Text('${response['message']}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void fetchAndUpdateBalance(BuildContext context) {
    BalanceProvider balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
    balanceProvider.fetchBalance();
  }
}
