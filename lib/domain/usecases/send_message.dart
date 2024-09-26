import 'package:test_app/domain/repositories/chat_repository.dart';

class SendMessage {
  final ChatRepository repository;

  SendMessage(this.repository);

  void call(String message) {
    repository.sendMessage(message);
  }
}
