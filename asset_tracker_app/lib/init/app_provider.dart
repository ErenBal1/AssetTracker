import 'package:asset_tracker_app/bloc/auth/auth_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/onboarding/onboarding_bloc.dart';
import 'package:asset_tracker_app/bloc/splash/splash_bloc.dart';
import 'package:asset_tracker_app/main.dart';
import 'package:asset_tracker_app/services/mock_service/mock_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(MockAuthService()),
        ),
        BlocProvider<OnboardingBloc>(
          create: (context) => OnboardingBloc(),
        ),
        BlocProvider<SplashBloc>(
          create: (context) => SplashBloc(),
        ),
        BlocProvider<HaremAltinBloc>(
          create: (context) => HaremAltinBloc(),
        ),
      ],
      child: const AssetTrackerMain(),
    );
  }
}
