import 'package:asset_tracker_app/utils/mixins/onboard_text_mixin.dart';
import 'package:asset_tracker_app/widgets/onboard_view/onboard_page_widget.dart';
import 'package:flutter/material.dart';

class OnboardingData with OnboardingTextMixin {
  List<OnboardingPage> get pages => [
        OnboardingPage(
          title: trackAssetsTitle,
          description: trackAssetsDescription,
          icon: Icons.track_changes,
        ),
        OnboardingPage(
          title: realTimeTitle,
          description: realTimeDescription,
          icon: Icons.update,
        ),
        OnboardingPage(
          title: analyticsTitle,
          description: analyticsDescription,
          icon: Icons.analytics,
        ),
      ];
}
