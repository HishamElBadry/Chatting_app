import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/presentation/bloc/chat_cubit.dart';
import 'package:test_app/presentation/bloc/chat_state.dart';
import 'package:test_app/presentation/pages/loading_page.dart';

class ChatPage extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  return ListView.builder(
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.messages[index]),
                      );
                    },
                  );
                }
                return Center(child: Text('Start chatting!'));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(hintText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (messageController.text.trim().isNotEmpty) {  // Check if the message is not empty
                      context.read<ChatCubit>().sendMessage(
                        messageController.text,
                      );
                      messageController.clear();  // Clear the text field after sending
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _sendMessage(BuildContext context, String message) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingPage()));

  context.read<ChatCubit>().sendMessage(message);

  Navigator.pop(context);  // Close the loading page
  Navigator.pushReplacementNamed(context, '/chat');  // Navigate back to chat page
}
