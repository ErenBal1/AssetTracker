abstract class IAuthService {
  Future<bool> signIn(String email, String password);
  Future<void> signOut();
  Future<bool> signUp(
      String email, String password, String firstName, String lastName);
}
