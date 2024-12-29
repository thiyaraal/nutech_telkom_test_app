import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/models/history_transaction_model.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/balance_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/service/history_transaction_service.dart';

class HistoryTransactionProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<TransactionRecord> _historyRecords = [];
  int _offset = 0;
  final int _limit = 5; // This is the number of records fetched per request
  bool _hasMore = true; // Indicates if there are more records to fetch

  List<TransactionRecord> get historyRecords => _historyRecords;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  final HistoryTransactionService _historyTransactionServices =
      HistoryTransactionService();

  HistoryTransactionProvider() {
    fetchHistoryTransaction();
  }

  Future<void> fetchHistoryTransaction({bool isInitialLoad = false}) async {
    if (isInitialLoad) {
      _offset = 0;
      _historyRecords = [];
      _hasMore = true;
    }

    _isLoading = true;
    notifyListeners();

    try {
      HistoryTransactionModel historyTransactionModel =
          await _historyTransactionServices.getHistoryTransaction(
              _offset, _limit);
      if (historyTransactionModel.data != null &&
          historyTransactionModel.data!.records != null) {
        _historyRecords.addAll(historyTransactionModel.data!.records!);
        _offset += _limit;
        if (historyTransactionModel.data!.records!.length < _limit) {
          _hasMore = false; // No more data to fetch
        }
      }
    } catch (e) {
      print("Error fetching history transaction: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}
