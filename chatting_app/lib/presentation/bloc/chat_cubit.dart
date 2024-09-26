import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/domain/usecases/send_message.dart';
import 'package:test_app/domain/usecases/get_messages.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendMessage sendMessageUseCase;
  final GetMessages getMessagesUseCase;
  List<String> _messages = [];

  ChatCubit({required this.sendMessageUseCase, required this.getMessagesUseCase})
      : super(ChatInitial()) {
    _listenForMessages();
  }

  void sendMessage(String message) {
    if (message.trim().isEmpty) return;  // Prevent sending empty messages

    sendMessageUseCase.call(message);
    _messages.add(message);
    emit(ChatLoaded(List.from(_messages)));  // Update the UI with the new message
  }

  void _listenForMessages() {
    emit(ChatLoading());
    getMessagesUseCase.call().listen((message) {
      _messages.add(message);
      emit(ChatLoaded(List.from(_messages)));
    }, onError: (error) {
      emit(ChatFailure(error.toString()));
    });
  }
}
