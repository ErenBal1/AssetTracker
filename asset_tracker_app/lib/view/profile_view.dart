import 'dart:async';
import 'package:asset_tracker_app/bloc/auth/auth_bloc.dart';
import 'package:asset_tracker_app/bloc/auth/auth_event.dart';
import 'package:asset_tracker_app/bloc/auth/auth_state.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:asset_tracker_app/utils/mixins/my_assets_view_mixin.dart';
import 'package:asset_tracker_app/widgets/profile_view/my_assets_card_listview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:asset_tracker_app/view/login_screen_view.dart';

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

  Future<void> _handleLogout() async {
    final shouldLogout = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Çıkış Yap'),
            content: const Text('Çıkış yapmak istediğinizden emin misiniz?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('İptal'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Çıkış Yap'),
              ),
            ],
          ),
        ) ??
        false;

    if (!shouldLogout) {
      return;
    }
    try {
      final authBloc = context.read<AuthBloc>();
      late final StreamSubscription<AuthState> subscription;

      subscription = authBloc.stream.listen((state) {
        if (state is AuthInitial) {
          subscription.cancel();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreenView(),
            ),
            (route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Başarıyla çıkış yapıldı'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is AuthError) {
          subscription.cancel();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Çıkış yapma hatası: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });

      authBloc.add(SignOutRequested());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Çıkış yaparken bir hata oluştu: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Toplam varlık değerini para formatında gösteren yardımcı fonksiyon
  String _formatCurrency(double amount) {
    // TL sembolü sağda olacak şekilde özel format oluşturuyoruz
    final turkishFormat = NumberFormat.currency(
      locale: 'tr_TR',
      symbol: 'TL',
      decimalDigits: 2,
      customPattern:
          '###,###,##0.00 \u00A4', // Para birimi sembolü sağa konumlandırıldı
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
    // Firebase Authentication durumunu kontrol edelim
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(
        child: Text(
            'Oturum açmış kullanıcı bulunamadı. Lütfen yeniden giriş yapın.'),
      );
    }

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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(LocalStrings.noAssetsAddedYet),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Yeniden veri yükleme denemesi
                    setState(() {});
                  },
                  child: const Text('Yenile'),
                ),
              ],
            ),
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

        // Kaydırılabilir alan kullanalım
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Toplam varlık değeri header'ı
              _buildTotalAssetsHeader(totalValue),

              // Varlıklar başlığı
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 24.0, bottom: 8.0),
                child: Text(
                  'Varlıklarım',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),

              // Varlık listesi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: _buildAssetsList(haremAltinState, assets),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Varlık listesini oluşturan fonksiyon
  Widget _buildAssetsList(
      HaremAltinDataLoaded haremAltinState, List<UserAsset> assets) {
    // Varlıkları türlerine göre gruplandıralım
    final Map<String, List<UserAsset>> groupedAssets = {};
    final Map<String, double> totalAmounts = {};
    final Map<String, double> totalValues = {};

    for (final asset in assets) {
      final typeName = asset.type.displayName;
      if (!groupedAssets.containsKey(typeName)) {
        groupedAssets[typeName] = [];
        totalAmounts[typeName] = 0;
        totalValues[typeName] = 0;
      }

      groupedAssets[typeName]!.add(asset);
      totalAmounts[typeName] = (totalAmounts[typeName] ?? 0) + asset.amount;

      final currentRate =
          haremAltinState.currentData.currencies[asset.type.name];
      if (currentRate != null) {
        totalValues[typeName] =
            (totalValues[typeName] ?? 0) + asset.getCurrentValue(currentRate);
      }
    }

    // Gruplandırılmış varlıkları listeleyelim
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: groupedAssets.length,
      itemBuilder: (context, index) {
        final typeName = groupedAssets.keys.elementAt(index);
        final amount = totalAmounts[typeName] ?? 0;
        final value = totalValues[typeName] ?? 0;

        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Varlık adı
                    Text(
                      typeName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Toplam miktar
                    Text(
                      '${amount.toStringAsFixed(4)} adet',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Toplam değer etiketi
                    Text(
                      'Toplam Değer:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    // Toplam değer
                    Text(
                      _formatCurrency(value),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                // Eğer bu türde birden fazla varlık varsa, detayları göster
                if (groupedAssets[typeName]!.length > 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ExpansionTile(
                      title: Text(
                        'Detaylar (${groupedAssets[typeName]!.length} adet)',
                        style: const TextStyle(fontSize: 14),
                      ),
                      children: groupedAssets[typeName]!.map((asset) {
                        final currentRate = haremAltinState
                            .currentData.currencies[asset.type.name];
                        final currentValue = currentRate != null
                            ? asset.getCurrentValue(currentRate)
                            : 0.0;

                        return ListTile(
                          dense: true,
                          title:
                              Text('${asset.amount.toStringAsFixed(4)} adet'),
                          subtitle: Text(
                            'Alış: ${_formatCurrency(asset.purchasePrice * asset.amount)}',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                          trailing: Text(
                            _formatCurrency(currentValue),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
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
