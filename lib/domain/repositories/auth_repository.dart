abstract class AuthRepository {
  Future<String> authenticate(String username, String password);
  Future<void> register(String username, String password);
}
