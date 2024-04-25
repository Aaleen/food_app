import 'package:donut_app/util/smoothie_tile.dart';
import 'package:flutter/material.dart';

class smoothieTab extends StatelessWidget {
  // list of donuts
  List donutsOnSale = [
    // [smoothieFlavor, donutPrice, donutColor, imageName]
    ["Banana", "110", Colors.brown, "assets/images/banana-smoothie.png"],
    ["Mango", "140", Colors.pink, "assets/images/smoothie-mango.png"],
    ["Strawberry", "50", Colors.blue, "assets/images/smoothie-strawberry.png"],
    ["Mint", "50", Colors.orange, "assets/images/smoothie-mint.png"],
    
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
        return smoothieTile(
          smoothieFlavor: donutsOnSale[index][0],
          smoothiePrice: donutsOnSale[index][1],
          smoothieColor: donutsOnSale[index][2],
          imageName: donutsOnSale[index][3],
        );
      },
    );
  }
}




