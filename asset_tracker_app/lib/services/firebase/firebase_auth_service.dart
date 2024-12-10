import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/enums/auth_service_error_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirebaseAuthService {
  Future<bool> signIn(String email, String password);
  Future<void> signOut();
}

class FirebaseAuthService implements IFirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      throw handleAuthError(e);
    } catch (e) {
      if (_auth.currentUser != null) {
        return true;
      }
      throw LocalStrings.loginError;
    }
  }

  String handleAuthError(FirebaseAuthException e) {
    final error = FirebaseAuthError.fromCode(e.code);
    return error == FirebaseAuthError.unknown
        ? '${error.message}${e.message}'
        : error.message;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}