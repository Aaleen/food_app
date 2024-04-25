import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class pizzaTile extends StatefulWidget {
  final String pizzaFlavor;
  final String pizzaPrice;
  final pizzaColor;
  final String imageName;

  const pizzaTile({
    super.key,
    required this.pizzaFlavor,
    required this.pizzaPrice,
    this.pizzaColor,
    required this.imageName,
  });

  @override
  State<pizzaTile> createState() => _pizzaTileState();
}

class _pizzaTileState extends State<pizzaTile> {
  final double borderRadius = 12;
  bool isClicked = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.pizzaColor[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // price
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: widget.pizzaColor[100],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                  ),
                  padding: EdgeInsets.all(borderRadius),
                  child: Text(
                    '\$' + widget.pizzaPrice,
                    style: TextStyle(
                      color: widget.pizzaColor[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),

            // donut image
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 52,
                vertical: 7,
              ),
              child: Image.asset(
                widget.imageName,
              ),
            ),

            // donut flavor
            Text(
              widget.pizzaFlavor,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              "Pizza",
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 12),

            // love icon + add button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // love icon
                  IconButton(
                    icon: isClicked
                        ? Icon(Icons.favorite_outline, color: Colors.pink)
                        : Icon(Icons.favorite, color: Colors.pink),
                    onPressed: () {
                      setState(() {
                        isClicked = !isClicked;
                      });
                    },
                    color: Colors.grey[900],
                  ),

                  // add button
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _showIngredientsModal(context);
                    },
                    color: Colors.grey[900],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showIngredientsModal(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: LottieBuilder.asset('assets/animations/food.json'),
        );
      },
    );
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
                  "Provide main ingredients of ${widget.pizzaFlavor} pizza only nothing else."
            }
          ],
        },
      ),
    );

    final jsonResponse = jsonDecode(response.body);
    final ingredients = jsonResponse['choices'][0]['message']['content'];
    // Close loading indicator
    Navigator.of(context).pop();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Image.asset(
                  widget.imageName,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 16),
                // Name
                Text(
                  widget.pizzaFlavor,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                // Ingredients
                Text(
                  "Ingredients:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  ingredients,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
