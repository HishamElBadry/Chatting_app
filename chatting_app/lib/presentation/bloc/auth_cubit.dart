import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/data/database/database_helper.dart';
import 'package:test_app/data/repositories/auth_repository_impl.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final DatabaseHelper databaseHelper;
  final AuthRepositoryImpl authRepository;

  AuthCubit({required this.databaseHelper, required this.authRepository}) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      final user = await databaseHelper.getUser(username);
      if (user == null || user['password'] != password) {
        emit(AuthFailure('Invalid username or password'));
      } else {
        emit(AuthSuccess('Login successful'));
      }
    } catch (e) {
      emit(AuthFailure('Failed to login: ${e.toString()}'));
    }
  }

  Future<void> register(String username, String password) async {
    emit(AuthLoading());
    try {
      await authRepository.registerUser(username, password);
      emit(AuthSuccess('Registration successful'));
    } catch (e) {
      emit(AuthFailure('Failed to register: ${e.toString()}'));
    }
  }
}
