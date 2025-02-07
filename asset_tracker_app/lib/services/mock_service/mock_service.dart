import 'package:asset_tracker_app/utils/constants/mock_service_user_credentials.dart';
import 'package:asset_tracker_app/utils/enums/auth_service_error_enum.dart';

abstract class IAuthService {
  Future<bool> signIn(String email, String password);
  Future<void> signOut();
}

class MockAuthService implements IAuthService {
  final Duration _networkSignInDelaySimulationDuration =
      const Duration(seconds: 1);
  @override
  Future<bool> signIn(String email, String password) async {
    await Future.delayed(_networkSignInDelaySimulationDuration);

    if (email != mockUserCredentials['email']) {
      throw FirebaseAuthError.userNotFound.message;
    }

    if (password != mockUserCredentials['password']) {
      throw FirebaseAuthError.wrongPassword.message;
    }

    return true;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
