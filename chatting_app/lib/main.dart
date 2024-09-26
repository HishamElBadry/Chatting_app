import 'package:flutter/material.dart';
import 'package:test_app/data/database/database_helper.dart';
import 'package:test_app/data/datasources/remote/websocket_mock.dart';
import 'package:test_app/data/repositories/chat_repository_impl.dart';
import 'package:test_app/data/repositories/auth_repository_impl.dart';
import 'package:test_app/domain/usecases/get_messages.dart';
import 'package:test_app/domain/usecases/send_message.dart';
import 'package:test_app/presentation/pages/chat_page.dart';
import 'package:test_app/presentation/pages/loading_page.dart';
import 'package:test_app/presentation/pages/login_page.dart';
import 'package:test_app/presentation/pages/registration_page.dart';
import 'package:test_app/presentation/pages/welcome_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/presentation/bloc/chat_cubit.dart';
import 'package:test_app/presentation/bloc/auth_cubit.dart';
import 'package:test_app/presentation/bloc/registration_cubit.dart';

void main() {
  final MockWebSocketService webSocketService = MockWebSocketService();
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final authRepository = AuthRepositoryImpl(databaseHelper: databaseHelper); // Initialize authRepository with databaseHelper
  final chatRepository = ChatRepositoryImpl(
    webSocketService: webSocketService,
    databaseHelper: databaseHelper,
  );

  runApp(MyApp(
    authRepository: authRepository,
    chatRepository: chatRepository,
    databaseHelper: databaseHelper,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final ChatRepositoryImpl chatRepository;
  final DatabaseHelper databaseHelper;

  MyApp({
    required this.authRepository,
    required this.chatRepository,
    required this.databaseHelper,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatCubit(
            sendMessageUseCase: SendMessage(chatRepository),
            getMessagesUseCase: GetMessages(chatRepository),
          ),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            authRepository: authRepository,
            databaseHelper: databaseHelper,
          ),
        ),
        BlocProvider(
          create: (context) => RegistrationCubit(
            authRepository: authRepository,
            databaseHelper: databaseHelper,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Remove the debug banner
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomePage(),
          '/register': (context) => RegistrationPage(),
          '/login': (context) => LoginPage(),
          '/chat': (context) => ChatPage(),
          '/loading': (context) => LoadingPage(),
        },
      ),
    );
  }
}
