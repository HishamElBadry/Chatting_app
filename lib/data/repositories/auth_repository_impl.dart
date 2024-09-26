import 'package:test_app/data/database/database_helper.dart';
import 'package:test_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl  {
  final DatabaseHelper databaseHelper;

  AuthRepositoryImpl({required this.databaseHelper});

  @override
  Future<void> registerUser(String username, String password) async {
    await databaseHelper.registerUser(username, password);
  }

  @override
  Future<Map<String, dynamic>?> getUser(String username) async {
    return await databaseHelper.getUser(username);
  }
}
