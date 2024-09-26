// domain/repositories/chat_repository.dart
abstract class ChatRepository {
  void connect(String url, String token);
  void sendMessage(String message);
  Stream<String> getMessages();
  void close();
}
