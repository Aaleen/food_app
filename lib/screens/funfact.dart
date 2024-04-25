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
        title: Text('Recipe or Fun Fact of the Day'),
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
                ),
              ),
              SizedBox(height: 20),
              isLoading
                  ? Lottie.asset(
                      'assets/images/food.json',
                      height: 100,
                      width: 100,
                    )
                  : Text(
                      responseText,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  getRandomFoodItem();
                  fetchRecipeOrFunFact();
                },
                child: Text('Generate Another'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
