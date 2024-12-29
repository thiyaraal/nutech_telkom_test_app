import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/font_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/models/services_model.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/balance_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/banner_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/profile_get_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/view_models/provider/service_provider.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/screen/payment_screen.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/screen/transaction_screen.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/widget/card_menu_home.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/widget/card_saldo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isViewSaldo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: Image.asset(
              'assets/images/logo/profile_small.png',
              width: 32,
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Image.asset(
            'assets/images/logo/Logo.png',
            width: 18,
          ),
        ),
        title: Text(
          'SIMS PPOB',
          style: MyTextStyles.titleTextSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 40.0,
          bottom: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat datang',
                style: MyTextStyles.titleTextLarge.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) {
                  // Ambil nama depan dan belakang
                  final fullName = profileProvider.profile?.fullName ?? '';
                  return Text(
                    fullName,
                    style: MyTextStyles.titleTextLarge,
                  );
                },
              ),
              const SizedBox(
                height: 36,
              ),
              Consumer<BalanceProvider>(
                builder: (context, balanceProvider, child) {
                  final balance = balanceProvider.balance ?? 0;
                  return CardSaldo(
                    isviewTextSaldo: true,
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
              const SizedBox(
                height: 20,
              ),
              Consumer<ServiceProvider>(
                builder: (context, serviceProvider, child) {
                  if (serviceProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (serviceProvider.services.isEmpty) {
                    return const Center(child: Text('No services found'));
                  }
                  // Menggunakan GridView.builder
                  return GridView.builder(
                    shrinkWrap: true,
                    physics:
                        NeverScrollableScrollPhysics(), // Disable scrolling of GridView
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 4, // Spasi vertikal antar item
                      childAspectRatio: 1.0, // Rasio lebar dan tinggi item
                    ),
                    itemCount: serviceProvider.services.length,
                    itemBuilder: (context, index) {
                      DataService service = serviceProvider.services[index];

                      return CardMenuHome(
                        onTap: () {
                          // kehalaham taransaksi

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentScreen(
                                // bawa data service ke halaman transaksi
                                serviceData: service,
                              ),
                            ),
                          );
                        },
                        imageMenu:
                            service.serviceIcon ?? 'path/to/default/icon.png',
                        titleMenu: service.serviceName ?? 'No Service Name',
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Temukan promo menarik',
                style: MyTextStyles.titleTextRegular.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<BannerProvider>(
                builder: (context, bannerProvider, child) {
                  if (bannerProvider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (bannerProvider.banners.isEmpty) {
                    return const Center(child: Text('No banner found'));
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: bannerProvider.banners.map((banner) {
                        return Row(
                          children: [
                            Image.network(banner.bannerImage ??
                                'default_image_path'), // Provide a default image path if necessary
                            const SizedBox(width: 12),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
