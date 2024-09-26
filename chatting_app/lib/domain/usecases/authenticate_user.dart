import 'package:test_app/domain/repositories/auth_repository.dart';

class AuthenticateUser {
  final AuthRepository repository;

  AuthenticateUser(this.repository);

  Future<String> call(String username, String password) async {
    return await repository.authenticate(username, password);
  }
}
