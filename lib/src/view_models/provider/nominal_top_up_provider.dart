import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/balance_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/service/topup_services.dart';

class TopUpProvider with ChangeNotifier {
  bool isLoading = false;
  String _selectedNominal = ''; // Stores the selected nominal
  final List<String> _nominalValues = [
    '10.000',
    '20.000',
    '50.000',
    '100.000',
    '250.000',
    '500.000',
  ];

  bool get isNominalValid =>
      _selectedNominal.isNotEmpty &&
      int.parse(_selectedNominal.replaceAll('.', '')) >= 10000 &&
      int.parse(_selectedNominal.replaceAll('.', '')) <= 1000000;

  TopupServices _topupServices =
      TopupServices(); // Instance of the TopupServices

  String get selectedNominal => _selectedNominal;
  List<String> get nominalValues => _nominalValues;
  bool get isNominalEmpty => _selectedNominal.isEmpty;

  void setNominal(String nominal) {
    _selectedNominal = nominal.replaceAll('.', '');
    notifyListeners();
  }

  void clearNominal() {
    _selectedNominal = '';
    notifyListeners();
  }

  Future<void> processTopUp(BuildContext context) async {
    if (isNominalEmpty) {
      print('Nominal tidak boleh kosong');
      return;
    }
    isLoading = true;
    notifyListeners();

    int amount = int.parse(_selectedNominal.replaceAll('.', ''));
    var result = await _topupServices.topup(amount);

    isLoading = false;
    notifyListeners();

    if (result['status'] == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Top Up Berhasil'),
            content: Text(
                'Kamu berhasil top up saldo kamu sekarang RP ${result['data']['balance']}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                   fetchAndUpdateBalance(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result['message']),
        backgroundColor: Colors.red,
      ));
    }
  }
   void fetchAndUpdateBalance(BuildContext context) {
    BalanceProvider balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
    balanceProvider.fetchBalance();
  }
}
