import 'package:asset_tracker_app/services/mock_service/mock_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final success = await _authService.signIn(
          event.email,
          event.password,
        );
        if (success) {
          emit(AuthAuthenticated());
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
