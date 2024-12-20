import 'package:asset_tracker_app/bloc/splash/splash_bloc.dart';
import 'package:asset_tracker_app/bloc/splash/splash_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin SplashScreenMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(CheckFirstTime());
  }
}
