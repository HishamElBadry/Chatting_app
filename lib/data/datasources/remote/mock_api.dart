import 'dart:convert';
import 'package:flutter/foundation.dart';

class MockApiService {
  // Simulate user authentication and return a token
  Future<String> authenticate(String username, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      if (username == 'test' && password == 'password') {
        return 'mock_token_123456';
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      debugPrint('Error during authentication: $e');
      rethrow;
    }
  }

  // Simulate fetching data from a WebSocket-like service
  Future<Map<String, dynamic>> getWebsocketResponse(String token, String query) async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

      if (token != 'mock_token_123456') {
        throw Exception('Invalid token');
      }

      // Simulated response
      return {
        'response': 'This is a mock response for your query: $query',
      };
    } catch (e) {
      debugPrint('Error during WebSocket response simulation: $e');
      rethrow;
    }
  }
}
