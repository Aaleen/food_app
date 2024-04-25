import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class DonutTile extends StatelessWidget {
  final String donutFlavor;
  final String donutPrice;
  final donutColor;
  final String imageName;

  final double borderRadius = 12;

  const DonutTile({
    super.key,
    required this.donutFlavor,
    required this.donutPrice,
    this.donutColor,
    required this.imageName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: donutColor[50],
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
                    color: donutColor[100],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                  ),
                  padding: EdgeInsets.all(borderRadius),
                  child: Text(
                    '\$' + donutPrice,
                    style: TextStyle(
                      color: donutColor[800],
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
                horizontal: 46,
                vertical: 16,
              ),
              child: Image.asset(
                imageName,
              ),
            ),

            // donut flavor
            Text(
              donutFlavor,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              "Donut",
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
                  Icon(
                    Icons.favorite_outline,
                    color: Colors.pink,
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
          child: LottieBuilder.asset('assets/images/food.json'),
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
                  "Provide main ingredients of $donutFlavor donut only nothing else."
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
                  imageName,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 16),
                // Name
                Text(
                  donutFlavor,
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
