import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/mixins/profile_view_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A view that displays user's financial profile including asset distribution,
/// total asset value, and detailed asset information.
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with ProfileViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocalStrings.profileLabel),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          // Transaction history button
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: LocalStrings.historyTooltip,
            onPressed: showTransactionsHistory,
          ),
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: LocalStrings.logoutTooltip,
            onPressed: handleLogout,
          ),
        ],
      ),
      body: BlocBuilder<HaremAltinBloc, HaremAltinState>(
        builder: (context, haremAltinState) {
          if (haremAltinState is HaremAltinDataLoaded) {
            return buildProfileContent(haremAltinState);
          }
          return const Text(LocalStrings.smthWentWrongError);
        },
      ),
    );
  }
}
