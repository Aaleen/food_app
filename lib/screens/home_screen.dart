import 'dart:convert';

import 'package:donut_app/models/response_model.dart';
import 'package:donut_app/screens/funfact.dart';
import 'package:donut_app/tabs/burger_tab.dart';
import 'package:donut_app/tabs/donut_tab.dart';
import 'package:donut_app/tabs/pancake_tab.dart';
import 'package:donut_app/tabs/pizza_tab.dart';
import 'package:donut_app/tabs/smoothie_tab.dart';
import 'package:donut_app/util/my_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // my tabs
  List<Widget> myTabs = [
    // donut tab
    myTab(
      iconPath: 'assets/icons/donut.png',
    ),

    // burger tab
    myTab(
      iconPath: 'assets/icons/burger.png',
    ),

    // smoothie tab
    myTab(
      iconPath: 'assets/icons/avocado.png',
    ),

    // pancake tab
    myTab(
      iconPath: 'assets/icons/pancake.png',
    ),

    // pizza tab
    myTab(
      iconPath: 'assets/icons/pizza.png',
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.restaurant_menu),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(),
                ));
          },
        ),
        // drawer: Drawer(
        //     child: ListTile(
        //   title: Text('Fact of the Day'),
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => RecipeOrFunFactPage(),
        //         ));
        //   },
        // )),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () => _showIngredientsModal(context),
              icon: Icon(Icons.cookie)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: IconButton(
                onPressed: () {
                  // profile
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.grey[800],
                  size: 36,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            // I want to eat
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 36,
                vertical: 18,
              ),
              child: Row(
                children: [
                  Text(
                    'Welcome to ',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Food Kitchen',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // tab bar
            TabBar(tabs: myTabs),

            // tab bar view
            Expanded(
              child: TabBarView(
                children: [
                  // donut page
                  donutTab(),

                  // burger page
                  burgerTab(),

                  // smoothie page
                  smoothieTab(),

                  // pancake page
                  pancakeTab(),

                  // pizza page
                  pizzaTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showIngredientsModal(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return RecipeOrFunFactPage();
        });
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  String _responseText = '';

  Future<void> _sendMessage() async {
    print("Bearer ${dotenv.env['token']}");
    setState(() {
      _responseText = 'Loading...';
    });

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${dotenv.env['token']!.trim()}",
      },
      body: jsonEncode(
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content":
                  "Behave like a world class Chef. Answer only food related questions"
            },
            {"role": "user", "content": _messageController.text}
          ],
          "max_tokens": 250,
          "temperature": 0,
          "top_p": 1,
        },
      ),
    );

    final jsonResponse = jsonDecode(response.body);
    final assistantMessage = jsonResponse['choices'][0]['message']['content'];

    setState(() {
      _responseText = assistantMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('World Class Chef'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              children: [
                _buildResponse(_responseText),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponse(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
