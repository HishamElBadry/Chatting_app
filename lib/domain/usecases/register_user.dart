import 'package:test_app/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<void> call(String username, String password) async {
    // You would implement the actual registration logic here.
    // For now, we'll just simulate a network call.
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return repository.register(username, password);
  }
}
