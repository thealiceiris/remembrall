import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'dart:convert';

class RemBotScreen extends StatefulWidget {
  // ignore: use_super_parameters
  const RemBotScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RemBotScreenState createState() => _RemBotScreenState();
}

class _RemBotScreenState extends State<RemBotScreen> {
  final List<String> messages = [];
  final TextEditingController messageController = TextEditingController();

  Future<void> makeApiRequest(String message) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000'), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'question': message}),
    );

    // Handle response from API
    setState(() {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // console.log(data);
        messages.add(data['response']); // Add bot message to list
      } else {
        messages.add('Error: ${response.statusCode}'); // Handle error
      }
    });
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
                  return _buildMessage(messages[index],
                      isUserMessage: index.isOdd);
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
                      setState(() {
                        messages.add(messageController.text);
                        messageController.clear();
                        makeApiRequest(messageController.text);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor:
                        const Color(0xFFD7BDE2), // Pastel purple color
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
              ? const Color(0xFFD7BDE2)
                  .withOpacity(0.8) // Pastel purple color with opacity
              : Colors.grey.shade200,
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isUserMessage ? Colors.white : Colors.black,
          ),
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
