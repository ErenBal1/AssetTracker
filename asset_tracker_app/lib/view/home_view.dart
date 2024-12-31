import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:asset_tracker_app/utils/mixins/home_screen_mixin.dart';
import 'package:asset_tracker_app/widgets/home_page/buttons/home_page_logout_button.dart';
import 'package:asset_tracker_app/widgets/home_page/harem_altin_table_widget.dart';
import 'package:asset_tracker_app/widgets/home_page/last_update_date.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> with HomeScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          HomePageLogoutButton(),
        ],
      ),
      body: const Column(
        children: [
          Padding(
            padding: ConstantPaddings.allXS,
            child: LastUpdateDate(),
          ),
          Expanded(
            child: HaremAltinTableWidget(),
          ),
        ],
      ),
    );
  }
}
