import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'chatwidgets.dart'; 
import 'custom_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatAiScreen extends StatefulWidget {
  final PageController pageController;
  final int selectedIndex;

  const ChatAiScreen({super.key, required this.pageController, required this.selectedIndex});

  @override
  _ChatAiScreenState createState() => _ChatAiScreenState();
}

class _ChatAiScreenState extends State<ChatAiScreen> {
  final TextEditingController _queryController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];  
  final PageController _pageController = PageController();
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _sendQuery() async {
  if (_queryController.text.isEmpty) return;

  // Retrieve the stored token from SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('authToken');  // Get the stored token

  // if (token == null || token.isEmpty) {
  //   // If no token found or token is empty, return early
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not authenticated')));
  //   return;
  // }

  setState(() {
    _isLoading = true;
    _messages.add({"role": "user", "type": "text", "content": _queryController.text});
    _queryController.clear();
  });

  try {
    final response = await http.post(
      Uri.parse('https://vitaria-0xc4.onrender.com/chat'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',  // Include the token in the Authorization header
      },
      body: json.encode({
        'user_id': "token", 
        'message': _messages.last["content"],  // Updated key to match the endpoint requirement
          // Send the token as the user ID
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        _messages.add({"role": "assistant", "type": "text", "content": responseData['response']});
      });
    } else {
      // Show validation error
      final errorData = json.decode(response.body);
      if (errorData['detail'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${errorData['detail'][0]['m+sg']}')));
      } else {
        throw Exception('Failed to load response');
      }
    }
  } catch (error) {
    setState(() {
      _messages.add({"role": "assistant", "type": "text", "content": "Error: $error"});
    });
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _messages.add({"role": "user", "type": "image", "content": File(image.path)});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chatbot'),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes the back arrow
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                if (message["type"] == "text") {
                  return ChatBubble(
                    message: message["content"],
                    isUser: message["role"] == "user",
                  );
                } else if (message["type"] == "image") {
                  return ImageBubble(image: message["content"]);
                }
                return SizedBox.shrink();
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Simple Plus Button (same style as Send)
                IconButton(
                  icon: Icon(Icons.add, size: 40),
                  onPressed: _pickImage,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: _queryController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendQuery,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: widget.selectedIndex,
        icons: [
          Icons.timeline,
          Icons.chat,
          Icons.calendar_today,
        ],
        routes: [
          '/timeline',
          '/chat',
          '/calendar',
        ],
        pageNames: [
          'Timeline',
          'Chat',
          'Calendar',
        ],
        onTap: (index) {
          if (widget.pageController.hasClients) {
            widget.pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
    );
  }
}
