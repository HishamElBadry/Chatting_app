import 'package:bloc/bloc.dart';
import 'package:test_app/data/database/database_helper.dart';
import 'package:test_app/data/repositories/auth_repository_impl.dart';
import 'package:test_app/presentation/bloc/registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final DatabaseHelper databaseHelper;
  final AuthRepositoryImpl authRepository;

  RegistrationCubit({
    required this.databaseHelper,
    required this.authRepository,
  }) : super(RegistrationInitial());

  Future<void> register(String username, String password) async {
    emit(RegistrationLoading());
    try {
      final existingUser = await databaseHelper.getUser(username);
      if (existingUser != null) {
        emit(RegistrationFailure('Username already exists'));
      } else {
        await authRepository.registerUser(username, password);
        emit(RegistrationSuccess());
      }
    } catch (e) {
      emit(RegistrationFailure('Failed to register: ${e.toString()}'));
    }
  }
}
