import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/data/database/database_helper.dart';
import 'package:test_app/data/datasources/remote/websocket_mock.dart';
import 'package:test_app/data/repositories/chat_repository_impl.dart';
import 'package:test_app/data/repositories/auth_repository_impl.dart'; // Import the correct AuthRepository implementation
import 'package:test_app/main.dart';

void main() {
  testWidgets('Chat Page loads and sends a message', (WidgetTester tester) async {
    // Initialize the WebSocket service and DatabaseHelper
    final MockWebSocketService webSocketService = MockWebSocketService();
    final DatabaseHelper databaseHelper = DatabaseHelper();

    // Initialize the repositories
    final authRepository = AuthRepositoryImpl(databaseHelper: databaseHelper);
    final chatRepository = ChatRepositoryImpl(
      webSocketService: webSocketService,
      databaseHelper: databaseHelper,
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      authRepository: authRepository,
      chatRepository: chatRepository,
      databaseHelper: databaseHelper,
    ));

    // Verify that the Chat page is displayed
    expect(find.text('Chat'), findsOneWidget);

    // Enter a message into the text field
    await tester.enterText(find.byType(TextField), 'Hello, World!');

    // Tap the send button (assuming you have an icon button with Icons.send)
    await tester.tap(find.byIcon(Icons.send));

    // Rebuild the widget with the new state
    await tester.pump();

    // Verify that the message is displayed in the chat
    expect(find.text('Hello, World!'), findsOneWidget);
  });
}
