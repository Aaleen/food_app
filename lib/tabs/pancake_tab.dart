import 'package:donut_app/util/pancake_tile.dart';
import 'package:flutter/material.dart';

class pancakeTab extends StatelessWidget {
  // list of donuts
  List donutsOnSale = [
    // [pancakeFlavor, donutPrice, donutColor, imageName]
    ["Apple Pie", "110", Colors.brown, "assets/images/apple-pie.png"],
    ["Maple Pie", "140", Colors.pink, "assets/images/pancake-maple.png"],
    ["Choco Pie", "50", Colors.blue, "assets/images/pancake-choco.png"],
    
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
        return pancakeTile(
          pancakeFlavor: donutsOnSale[index][0],
          pancakePrice: donutsOnSale[index][1],
          pancakeColor: donutsOnSale[index][2],
          imageName: donutsOnSale[index][3],
        );
      },
    );
  }
}




