import 'package:asset_tracker_app/localization/strings.dart';

enum FirebaseAuthError {
  userNotFound('user-not-found'),
  wrongPassword('wrong-password'),
  userDisabled('user-disabled'),
  invalidEmail('invalid-email'),
  invalidCredential('invalid-credential'),
  tooManyRequests('too-many-requests'),
  unknown('unknown');

  final String code;
  const FirebaseAuthError(this.code);
}

extension FirebaseAuthErrorX on FirebaseAuthError {
  String get message {
    switch (this) {
      case FirebaseAuthError.userNotFound:
        return LocalStrings.userNotFound;
      case FirebaseAuthError.wrongPassword:
        return LocalStrings.wrongPassword;
      case FirebaseAuthError.userDisabled:
        return LocalStrings.userDisabled;
      case FirebaseAuthError.invalidEmail:
        return LocalStrings.invalidEmail;
      case FirebaseAuthError.invalidCredential:
        return LocalStrings.invalidCredential;
      case FirebaseAuthError.tooManyRequests:
        return LocalStrings.tooManyRequests;
      case FirebaseAuthError.unknown:
        return LocalStrings.defaultError;
    }
  }
}

extension StringFirebaseAuthErrorX on String {
  FirebaseAuthError toFirebaseAuthError() {
    return FirebaseAuthError.values.firstWhere(
      (error) => error.code == this,
      orElse: () => FirebaseAuthError.unknown,
    );
  }
}
