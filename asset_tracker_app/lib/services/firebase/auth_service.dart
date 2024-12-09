import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in.
  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError2(e);
    } catch (e) {
      if (_auth.currentUser != null) {
        return true;
      }
      throw "There was an error logging in. Please try again.";
    }
  }

  String _handleAuthError2(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No users registered with this email.';
      case 'wrong-password':
        return 'You entered an incorrect password.';
      case 'user-disabled':
        return 'This account has been deactivated.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'invalid-credential':
        return 'Email or password incorrect.';
      case 'too-many-requests':
        return 'You have made too many failed login attempts. Please try again later.';
      default:
        return 'An error occurred: ${e.message}';
    }
  }

  // Sign up.
  Future<bool> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      return true;
    }
  }

  // Sign out.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Handling errors.
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password is too weak. Use at least 6 characters.';
      case 'email-already-in-use':
        return 'This email address is already in use.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'operation-not-allowed':
        return 'Email/password login is not active.';
      default:
        return 'An error has occurred: ${e.message}';
    }
  }
}
