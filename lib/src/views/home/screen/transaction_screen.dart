import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/font_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/models/history_transaction_model.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/balance_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/history_transaction_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/widget/card_saldo.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/widget/history_transactions.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({
    super.key,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  void fetchAndUpdateBalance(BuildContext context) {
    //ambil data balance dari provider

    BalanceProvider balanceProvider =
        Provider.of<BalanceProvider>(context, listen: false);
    balanceProvider.fetchBalance();
  }
  bool isViewSaldo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: null,
        automaticallyImplyLeading: false,
        title: Text('Transaksi', style: MyTextStyles.titleTextMedium),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<HistoryTransactionProvider>(context, listen: false)
              .fetchHistoryTransaction(isInitialLoad: true);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
                Text('Transaksi',
                    style: MyTextStyles.titleTextMedium
                        .copyWith(fontWeight: FontWeight.w300)),
                const SizedBox(height: 20),
                Consumer<HistoryTransactionProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading && provider.historyRecords.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (provider.historyRecords.isEmpty) {
                      return Center(
                          child: Text("No transaction history available."));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: provider.historyRecords.length +
                          (provider.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == provider.historyRecords.length) {
                          return provider.hasMore
                              ? Center(
                                  child: TextButton(
                                    onPressed: () =>
                                        provider.fetchHistoryTransaction(
                                            isInitialLoad: false),
                                    child: Text("Show More"),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Center(child: Text("No more data")),
                                );
                        }
                        TransactionRecord record =
                            provider.historyRecords[index];
                        return HistoryTransactions(
                          amount: record.totalAmount.toString(),
                          originalDate: record.createdOn.toString(),
                          originalTime: record.createdOn.toString(),
                          description: record.description.toString(),
                          isIncome: record.transactionType == "TOPUP",
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
