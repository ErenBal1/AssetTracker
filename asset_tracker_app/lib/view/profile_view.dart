import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:asset_tracker_app/utils/mixins/profile_view_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with ProfileViewMixin {
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

              // Grafiksel gösterim başlığı
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 24.0, bottom: 8.0),
                child: Text(
                  'Varlık Dağılımı',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),

              // Grafikler kısmı
              _buildCharts(haremAltinState, assets, totalValue),

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

  // Grafiksel gösterim oluşturan fonksiyon
  Widget _buildCharts(HaremAltinDataLoaded haremAltinState,
      List<UserAsset> assets, double totalValue) {
    // Varlıkları türlerine göre gruplandıralım ve değerlerini hesaplayalım
    final Map<String, double> assetValues = {};
    final List<Color> chartColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.amber,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.cyan,
    ];

    // Her varlık türü için toplam değeri hesapla
    for (final asset in assets) {
      final typeName = asset.type.displayName;
      final currentRate =
          haremAltinState.currentData.currencies[asset.type.name];

      if (currentRate != null) {
        final value = asset.getCurrentValue(currentRate);
        assetValues[typeName] = (assetValues[typeName] ?? 0) + value;
      }
    }

    // Grafikler için veri hazırlama
    final sections = <PieChartSectionData>[];
    final barGroups = <BarChartGroupData>[];

    int index = 0;
    assetValues.forEach((typeName, value) {
      final percentage = (value / totalValue * 100).toStringAsFixed(1);
      final colorIndex = index % chartColors.length;

      // Pasta grafik bölümleri
      sections.add(
        PieChartSectionData(
          color: chartColors[colorIndex],
          value: value,
          title: '$percentage%',
          radius: 80,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );

      // Çubuk grafik verileri
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: value,
              color: chartColors[colorIndex],
              width: 20,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ],
        ),
      );

      index++;
    });

    return Column(
      children: [
        // Pasta Grafik
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Varlık Dağılımı (Pasta Grafik)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: sections,
                      centerSpaceRadius: 40,
                      sectionsSpace: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16.0,
                  runSpacing: 8.0,
                  children: assetValues.keys.map((typeName) {
                    final colorIndex =
                        assetValues.keys.toList().indexOf(typeName) %
                            chartColors.length;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: chartColors[colorIndex],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          typeName,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),

        // Çubuk Grafik
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Varlık Değerleri (Çubuk Grafik)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: assetValues.values.isEmpty
                          ? 0
                          : assetValues.values.reduce((a, b) => a > b ? a : b) *
                              1.2,
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >= 0 &&
                                  value.toInt() < assetValues.length) {
                                final typeName =
                                    assetValues.keys.elementAt(value.toInt());
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    typeName.length > 8
                                        ? '${typeName.substring(0, 8)}..'
                                        : typeName,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: barGroups,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
            onPressed: showTransactionsHistory,
          ),
          // Çıkış yap butonu
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Çıkış Yap',
            onPressed: handleLogout,
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
