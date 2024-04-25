import 'package:donut_app/util/pizza_tile.dart';
import 'package:donut_app/util/pizza_tile.dart';
import 'package:flutter/material.dart';

class pizzaTab extends StatelessWidget {
  // list of donuts
  List donutsOnSale = [
    // [pizzaFlavor, donutPrice, donutColor, imageName]
    ["Fajita", "110", Colors.brown, "assets/images/pizza-fajita.png"],
    ["Afghani", "140", Colors.pink, "assets/images/pizza-afghani.png"],
    ["Tikka", "50", Colors.blue, "assets/images/pizza-tika.png"],
    ["Cheesy", "50", Colors.orange, "assets/images/pizza-cheese.png"],
    
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: donutsOnSale.length,
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5
      ),
      itemBuilder: (context, index) {
        return pizzaTile(
          pizzaFlavor: donutsOnSale[index][0],
          pizzaPrice: donutsOnSale[index][1],
          pizzaColor: donutsOnSale[index][2],
          imageName: donutsOnSale[index][3],
        );
      },
    );
  }
}




