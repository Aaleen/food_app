import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class RecipeOrFunFactPage extends StatefulWidget {
  @override
  _RecipeOrFunFactPageState createState() => _RecipeOrFunFactPageState();
}

class _RecipeOrFunFactPageState extends State<RecipeOrFunFactPage> {
  final List<String> foodItems = [
    "Apple",
    "Banana",
    "Chicken",
    "Rice",
    "Pizza",
    "Salad",
    "Pasta",
    "Fish",
    "Beef",
    "Eggs",
    "Bread",
    "Cheese",
    "Yogurt",
    "Spinach",
    "Tomatoes",
    "Carrots",
    "Broccoli",
    "Milk",
    "Oranges",
    "Potatoes",
    "Avocado",
    "Strawberries",
    "Watermelon",
    "Cucumber",
    "Peanuts",
    "Almonds",
    "Salmon",
    "Tofu",
    "Quinoa",
    "Oats"
  ];

  String selectedItem = '';
  String responseText = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getRandomFoodItem();
  }

  void getRandomFoodItem() {
    final random = Random();
    final index = random.nextInt(foodItems.length);
    selectedItem = foodItems[index];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchRecipeOrFunFact();
  }

  void fetchRecipeOrFunFact() async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['token']!.trim()}',
      },
      body: jsonEncode(
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content":
                  "Provide a single sentence fun fact only about $selectedItem."
            }
          ],
        },
      ),
    );

    final jsonResponse = jsonDecode(response.body);
    final text = jsonResponse['choices'][0]['message']['content'];

    setState(() {
      responseText = text;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tastebuds to Trivia: Your Daily Fix Awaits!",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Today\'s Food: $selectedItem',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]
                ),
              ),
              SizedBox(height: 20),
              isLoading
                  ? Lottie.asset(
                      'assets/animations/food.json',
                      height: 100,
                      width: 100,
                    )
                  : Text(
                      responseText,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[800]
                      ),
                      textAlign: TextAlign.center,
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[100], // Change this to your desired color
                  // Other properties you can customize:
                  // onPrimary: Colors.white,
                  // shadowColor: Colors.black,
                  // elevation: 5,
                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  getRandomFoodItem();
                  fetchRecipeOrFunFact();
                },
                child: Text('Generate Another', style: TextStyle(color: Colors.grey[800]),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
