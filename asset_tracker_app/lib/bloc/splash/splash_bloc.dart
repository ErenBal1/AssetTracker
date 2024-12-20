import 'package:asset_tracker_app/bloc/splash/splash_event.dart';
import 'package:asset_tracker_app/bloc/splash/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckFirstTime>((event, emit) async {
      emit(SplashLoading());
      await Future.delayed(const Duration(seconds: 3));

      final bool isFirstTime = await _isFirstTimeUser();

      if (isFirstTime) {
        emit(NavigateToOnboarding());
      } else {
        emit(NavigateToLogin());
      }
    });
  }

  Future<bool> _isFirstTimeUser() async {
    // İlk kullanım kontrolü burada yapılacak
    return true;
  }
}
