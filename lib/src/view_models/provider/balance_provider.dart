import 'package:flutter/foundation.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/service/balance_services.dart';

class BalanceProvider extends ChangeNotifier {
  int? _balance;
    bool _isLoading = false;


  int? get balance => _balance;
  bool get isLoading => _isLoading;


  final BalanceService _service = BalanceService();

 BalanceProvider() {
    fetchBalance();
  }
  Future<void> fetchBalance() async {
    _isLoading = true;
    notifyListeners();
  

    final balanceData = await _service.getBalance();
    _balance = balanceData.data.balance;
    _isLoading = false;
    notifyListeners();
    }
    
}
