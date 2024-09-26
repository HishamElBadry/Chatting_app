import 'package:test_app/domain/repositories/chat_repository.dart';

class GetMessages {
  final ChatRepository repository;

  GetMessages(this.repository);

  Stream<String> call() {
    return repository.getMessages();
  }
}
