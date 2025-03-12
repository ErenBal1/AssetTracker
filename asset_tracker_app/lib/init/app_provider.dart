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
          create: (context) {
            return UserAssetRepositoryImpl();
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) {
              return AuthBloc(FirebaseAuthService());
            },
          ),
          BlocProvider<HaremAltinBloc>(
            create: (context) {
              return HaremAltinBloc();
            },
          ),
          BlocProvider<MyAssetsBloc>(
            create: (context) {
              return MyAssetsBloc(
                userAssetRepository: context.read<UserAssetRepository>(),
                haremAltinBloc: context.read<HaremAltinBloc>(),
              );
            },
          ),
          BlocProvider<OnboardingBloc>(
            create: (context) {
              return OnboardingBloc();
            },
          ),
          BlocProvider<SplashBloc>(
            create: (context) {
              return SplashBloc();
            },
          ),
          BlocProvider<AssetFormBloc>(
            create: (context) {
              return AssetFormBloc(
                userAssetRepository: context.read<UserAssetRepository>(),
              );
            },
          ),
        ],
        child: const AssetTrackerMain(),
      ),
    );
  }
}
