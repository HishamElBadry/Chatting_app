abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<String> messages;

  ChatLoaded(this.messages);
}

class ChatFailure extends ChatState {
  final String error;

  ChatFailure(this.error);
}
