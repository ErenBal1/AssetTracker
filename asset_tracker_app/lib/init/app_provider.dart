import 'package:asset_tracker_app/bloc/auth/auth_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/onboarding/onboarding_bloc.dart';
import 'package:asset_tracker_app/bloc/my_assets/my_assets_bloc.dart';
import 'package:asset_tracker_app/bloc/splash/splash_bloc.dart';
import 'package:asset_tracker_app/bloc/asset_form/asset_form_bloc.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:asset_tracker_app/main.dart';
import 'package:asset_tracker_app/services/firebase/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserAssetRepository>(
          create: (context) => UserAssetRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MyAssetsBloc>(
            create: (context) => MyAssetsBloc(
              userAssetRepository: context.read<UserAssetRepository>(),
              haremAltinBloc: context.read<HaremAltinBloc>(),
            ),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(FirebaseAuthService()),
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
          BlocProvider<AssetFormBloc>(
            create: (context) => AssetFormBloc(
              userAssetRepository: context.read<UserAssetRepository>(),
            ),
          ),
        ],
        child: const AssetTrackerMain(),
      ),
    );
  }
}
