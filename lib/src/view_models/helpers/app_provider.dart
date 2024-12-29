import 'package:provider/provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/balance_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/banner_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/history_transaction_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/login_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/nominal_top_up_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/profile_get_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/profile_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/registarsi_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/service_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/textfield_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/transaction_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/service/service_services.dart';

class AppProviders {
  static List<ChangeNotifierProvider> providers() {
    return [
      ChangeNotifierProvider<FormFieldProvider>(
          create: (_) => FormFieldProvider()),
      ChangeNotifierProvider<TopUpProvider>(create: (_) => TopUpProvider()),
      ChangeNotifierProvider<ProfileEditProvider>(
          create: (_) => ProfileEditProvider()),
      ChangeNotifierProvider<RegistrationProvider>(
          create: (_) => RegistrationProvider()),
          ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider()),

          ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider()),

          ChangeNotifierProvider<BalanceProvider>(
          create: (_) => BalanceProvider()),

          ChangeNotifierProvider<ServiceProvider>(
          create: (_) => ServiceProvider()),

          ChangeNotifierProvider<BannerProvider>( 
          create: (_) => BannerProvider()),
         ChangeNotifierProvider<TransactionProvider>(
          create: (_) => TransactionProvider()),

          ChangeNotifierProvider<HistoryTransactionProvider>(
          create: (_) => HistoryTransactionProvider()),
    ];
  }
}
