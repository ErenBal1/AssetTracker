import 'dart:async';
import 'package:asset_tracker_app/bloc/auth/auth_bloc.dart';
import 'package:asset_tracker_app/bloc/auth/auth_event.dart';
import 'package:asset_tracker_app/bloc/auth/auth_state.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_event.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:asset_tracker_app/view/login_screen_view.dart';
import 'package:asset_tracker_app/widgets/profile_view/charts/asset_distribution_charts.dart';
import 'package:asset_tracker_app/widgets/profile_view/asset_list_section.dart';
import 'package:asset_tracker_app/widgets/profile_view/loading_widget.dart';
import 'package:asset_tracker_app/widgets/profile_view/section_title.dart';
import 'package:asset_tracker_app/widgets/profile_view/total_assets_header.dart';
import 'package:asset_tracker_app/viewmodels/profile_viewmodel.dart';
import 'package:asset_tracker_app/widgets/profile_view/my_assets_card_listview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin ProfileViewMixin<ProfileViewState extends StatefulWidget>
    on State<ProfileViewState> {
  late final HaremAltinBloc _haremAltinBloc;
  late ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    _haremAltinBloc = context.read<HaremAltinBloc>();
    _haremAltinBloc.add(ConnectToWebSocket());
    viewModel = ProfileViewModel(
      userAssetRepository: context.read<UserAssetRepository>(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_haremAltinBloc.state is HaremAltinDataLoaded) {
        _haremAltinBloc.add(DisconnectWebSocket());
      }
    });
    super.dispose();
  }

  void showTransactionsHistory() {
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
                  return MyAssetsCardListView(haremAltinState: haremAltinState);
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
            )),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(LocalStrings.close),
          ),
        ],
      ),
    );
  }

  Future<void> handleLogout() async {
    final shouldLogout = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(LocalStrings.logoutTooltip),
            content: const Text(LocalStrings.logoutConfirmation),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(LocalStrings.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(LocalStrings.logoutTooltip),
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
              content: Text(LocalStrings.logoutSuccess),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is AuthError) {
          subscription.cancel();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${LocalStrings.logoutError}${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });

      authBloc.add(SignOutRequested());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${LocalStrings.logoutGeneralError}$e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Builds the main content of the profile screen
  Widget buildProfileContent(HaremAltinDataLoaded haremAltinState) {
    // Check Firebase Authentication state
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Text(LocalStrings.noUserFoundError);
    }

    return StreamBuilder<List<UserAsset>>(
      stream: viewModel.userAssetsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('${LocalStrings.errorOccurred} ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const LoadingWidget();
        }

        final assets = snapshot.data!;
        if (assets.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(LocalStrings.noAssetsAddedYet),
                const GapSize.medium(),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  child: const Text(LocalStrings.retry),
                ),
              ],
            ),
          );
        }

        // Calculate total asset value
        final totalValue = viewModel.calculateTotalAssetValue(
            assets, haremAltinState.currentData.currencies);

        // Use scrollable area for content
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total assets value header
              TotalAssetsHeader(totalAssetValue: totalValue),

              // Asset distribution title
              const SectionTitle(title: LocalStrings.assetDistribution),

              // Charts section
              AssetDistributionCharts(
                assets: assets,
                currencies: haremAltinState.currentData.currencies,
                totalValue: totalValue,
                viewModel: viewModel,
              ),

              // Assets list title
              const SectionTitle(title: LocalStrings.myAssets),

              // Assets list
              Padding(
                padding: ConstantPaddings.horizontalM,
                child: AssetListSection(
                  assets: assets,
                  currencies: haremAltinState.currentData.currencies,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
