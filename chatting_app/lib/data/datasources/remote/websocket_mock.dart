import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class MockWebSocketService {
  late final WebSocketChannel channel;
  bool _isConnected = false;

  // Method to connect to a WebSocket server
  void connect(String url, String token) {
    // Ensure channel is initialized before use
    channel = IOWebSocketChannel.connect(Uri.parse(url));
    _isConnected = true;
    print('Connected to WebSocket server at $url');
  }

  // Ensure connection is established before sending a message
  void _ensureConnected() {
    if (!_isConnected) {
      connect('ws://localhost:8080', 'token'); // Replace with actual URL and token
    }
  }

  // Method to send a message through the WebSocket
  void sendMessage(String message) {
    try {
      _ensureConnected();
      channel.sink.add(message);
      print('Message sent: $message');
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  // Method to listen for messages from the WebSocket
  Stream<String> getMessages() {
    _ensureConnected();
    return channel.stream.map((event) {
      print('Received message: $event');
      return 'Mock response to: $event';
    }).handleError((error) {
      print('Error receiving message: $error');
    });
  }

  // Method to close the WebSocket connection
  void close() {
    try {
      channel.sink.close();
      _isConnected = false;
      print('WebSocket connection closed');
    } catch (e) {
      print('Error closing WebSocket connection: $e');
    }
  }
}
