import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:asset_tracker_app/utils/mixins/my_assets_view_mixin.dart';
import 'package:asset_tracker_app/widgets/profile_view/my_assets_card_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with ProfileViewMixin {
  void _showTransactionsHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(LocalStrings.transactionHistoryLabel),
        content: SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.6,
          child: BlocBuilder<HaremAltinBloc, HaremAltinState>(
            builder: (context, haremAltinState) {
              if (haremAltinState is HaremAltinDataLoaded) {
                return MyAssetsCardListView(
                  haremAltinState: haremAltinState,
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                );
              }
              if (haremAltinState is HaremAltinDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (haremAltinState is HaremAltinError) {
                return const Center(
                  child: Text(LocalStrings.unableToLoadAssetsError),
                );
              }

              return const Center(
                child: Text(LocalStrings.smthWentWrongError),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  void _handleLogout() {
    // Burada çıkış yapma mantığını ekleyebilirsiniz
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Çıkış yapıldı')),
    );
  }

  // Toplam varlık değerini para formatında gösteren yardımcı fonksiyon
  String _formatCurrency(double amount) {
    final turkishFormat = NumberFormat.currency(
      locale: 'tr_TR',
      symbol: 'TL',
      decimalDigits: 2,
    );
    return turkishFormat.format(amount);
  }

  // Toplam varlık değerini gösteren header widget'ı
  Widget _buildTotalAssetsHeader(double totalAssetValue) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Text(
              'Toplam Varlık Değeri',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text(
              _formatCurrency(totalAssetValue),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_upward,
                        color: Colors.white, size: 16),
                    const SizedBox(height: 4),
                    Text(
                      'Kazanç',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 30,
                  width: 1,
                  color: Colors.white.withOpacity(0.3),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.bar_chart, color: Colors.white, size: 16),
                    const SizedBox(height: 4),
                    Text(
                      'Performans',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Kullanıcı varlıklarının toplam değerini hesaplayan fonksiyon
  Widget _buildProfileContent(HaremAltinDataLoaded haremAltinState) {
    return StreamBuilder<List<UserAsset>>(
      stream: context.read<UserAssetRepository>().getUserAssets(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(LocalStrings.errorOccurred + snapshot.error.toString()),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final assets = snapshot.data!;
        if (assets.isEmpty) {
          return const Center(
            child: Text(LocalStrings.noAssetsAddedYet),
          );
        }

        // Toplam varlık değerini hesapla
        double totalValue = 0.0;
        for (final asset in assets) {
          final currentRate =
              haremAltinState.currentData.currencies[asset.type.name];
          if (currentRate != null) {
            totalValue += asset.getCurrentValue(currentRate);
          }
        }

        // Kaydırılabilir alan yerine Column kullanalım ve ListView'e yükseklik sınırı ekleyelim
        return Column(
          children: [
            // Toplam varlık değeri header'ı
            _buildTotalAssetsHeader(totalValue),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocalStrings.profileLabel),
        actions: [
          // İşlem geçmişi butonu
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'İşlem Geçmişi',
            onPressed: _showTransactionsHistory,
          ),
          // Çıkış yap butonu
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Çıkış Yap',
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: BlocBuilder<HaremAltinBloc, HaremAltinState>(
        builder: (context, haremAltinState) {
          if (haremAltinState is HaremAltinDataLoaded) {
            return _buildProfileContent(haremAltinState);
          }

          return const Center(
            child: Text(LocalStrings.smthWentWrongError),
          );
        },
      ),
    );
  }
}
