import 'package:flutter/material.dart';

class RemBotScreen extends StatefulWidget {
  const RemBotScreen({Key? key}) : super(key: key);

  @override
  _RemBotScreenState createState() => _RemBotScreenState();
}

class _RemBotScreenState extends State<RemBotScreen> {
  final List<String> messages = [];

  final TextEditingController messageController = TextEditingController();

  void _sendMessage(String message) {
    setState(() {
      messages.add(message);
    });
    // ... your existing logic to handle the message
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RemBot',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal, // Set app bar color
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0), // Add padding to content area
        child: Column(
          children: [
            const Text(
              'Hi there! I\'m RemBot, your ADHD educational chatbot.',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0), // Add spacing between welcome and input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Ask me about ADHD...', // Suggest asking about ADHD
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0), // Rounded corners
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.teal), // Color the send icon
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      _sendMessage(messageController.text);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8.0), // Add spacing between input and list
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return _buildMessage(messages[index], isUserMessage: index % 2 == 1);
                },
              ),
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
          borderRadius: BorderRadius.circular(8.0),
          color: isUserMessage ? Colors.teal.shade100 : Colors.grey.shade200,
        ),
        child: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
