abstract class IAuthService {
  Future<bool> signIn(String email, String password);
  Future<void> signOut();
}
