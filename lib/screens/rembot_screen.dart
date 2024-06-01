import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RemBotScreen extends StatefulWidget {
  const RemBotScreen({super.key});

  @override
  _RemBotScreenState createState() => _RemBotScreenState();
}

class _RemBotScreenState extends State<RemBotScreen> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController messageController = TextEditingController();

  Future<void> sendMessage(String message) async {
    final url = Uri.parse(
        'http://10.0.2.2:5000/ask'); // Using emulator loopback address
    setState(() {
      messages.add({'message': message, 'isUserMessage': true}); // Add the user's message to the list
    });
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'question': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          messages.add({'message': data['response'], 'isUserMessage': false}); // Add the server's response to the list
        });
      } else {
        setState(() {
          messages.add({'message': "Error: Unable to get response from server.", 'isUserMessage': false});
        });
      }
    } catch (e) {
      setState(() {
        messages.add({'message': "Error: ${e.toString()}", 'isUserMessage': false});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 51, 33, 33), // Make background transparent
      appBar: AppBar(
        title: const Text(
          'RemBot',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD7BDE2), // Pastel purple color
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true, // Display messages from newest to oldest
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return _buildMessage(message['message'], isUserMessage: message['isUserMessage']);
                },
              ),
            ),
            const SizedBox(height: 8.0), // Add spacing between list and input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Ask a question about ADHD...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      sendMessage(messageController.text);
                      messageController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: const Color(0xFFD7BDE2), // Pastel purple color
                  ),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(String message, {required bool isUserMessage}) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: isUserMessage
              ? const Color(0xFFD7BDE2).withOpacity(0.8)
              : Colors.grey.shade200,
        ),
        child: Text(
          message,
          style: TextStyle(color: isUserMessage ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}