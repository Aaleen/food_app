import 'package:donut_app/util/burger_tile.dart';
import 'package:flutter/material.dart';

class burgerTab extends StatelessWidget {
  // list of donuts
  List donutsOnSale = [
    // [burgerFlavor, donutPrice, donutColor, imageName]
    ["Cheese", "110", Colors.brown, "assets/images/donut-1.png"],
    ["Zinger", "140", Colors.pink, "assets/images/donut-4.png"],
    ["Beef", "50", Colors.blue, "assets/images/donut-2.png"],
    ["Veg", "10", Colors.red, "assets/images/donut-3.png"],
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
        return burgerTile(
          burgerFlavor: donutsOnSale[index][0],
          burgerPrice: donutsOnSale[index][1],
          burgerColor: donutsOnSale[index][2],
          imageName: donutsOnSale[index][3],
        );
      },
    );
  }
}




