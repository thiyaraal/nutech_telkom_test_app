import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/helpers/app_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/helpers/app_routes.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/helpers/shared+prefrences.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init(); // Inisialisasi SharedPreferences
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.providers(),
      child: MaterialApp(
        title: 'SIMS PPOB',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
