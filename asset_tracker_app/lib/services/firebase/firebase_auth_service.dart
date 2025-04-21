import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/services/auth_service.dart';
import 'package:asset_tracker_app/utils/enums/auth_service_error_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements IAuthService {
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
      throw _handleAuthError(e);
    } catch (e) {
      if (_auth.currentUser != null) {
        return true;
      }
      throw LocalStrings.loginError;
    }
  }

  @override
  Future<bool> signUp(
      String email, String password, String firstName, String lastName) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user?.updateDisplayName('$firstName $lastName');
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw LocalStrings.signupError;
    }
  }

  String _handleAuthError(FirebaseAuthException e) {
    final error = e.code.toFirebaseAuthError();
    return error == FirebaseAuthError.unknown
        ? '${error.message}${e.message}'
        : error.message;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
