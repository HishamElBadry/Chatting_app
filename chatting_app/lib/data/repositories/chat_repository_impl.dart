import 'package:rxdart/rxdart.dart';
import 'package:test_app/data/database/database_helper.dart';
import 'package:test_app/data/datasources/remote/websocket_mock.dart';
import 'package:test_app/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final MockWebSocketService webSocketService;
  final DatabaseHelper databaseHelper;

  ChatRepositoryImpl({required this.webSocketService, required this.databaseHelper});

  @override
  void connect(String url, String token) {
    webSocketService.connect(url, token);
  }

  @override
  void sendMessage(String message) {
    webSocketService.sendMessage(message);
    databaseHelper.insertMessage(message); // Save message to the local database
  }

  @override
  Stream<String> getMessages() {
    // First, retrieve any saved messages from the database
    final localMessages = databaseHelper.getMessages().asStream()
        .flatMap((messagesList) => Stream.fromIterable(messagesList));

    // Then, listen to the WebSocket for new messages
    final webSocketMessages = webSocketService.getMessages();

    // Merge local and WebSocket messages streams
    return Rx.merge([localMessages, webSocketMessages]);
  }

  @override
  void close() {
    webSocketService.close();
  }
}
