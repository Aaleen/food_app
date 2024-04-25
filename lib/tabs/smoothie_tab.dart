import 'package:donut_app/util/smoothie_tile.dart';
import 'package:flutter/material.dart';

class smoothieTab extends StatelessWidget {
  // list of donuts
  List donutsOnSale = [
    // [smoothieFlavor, donutPrice, donutColor, imageName]
    ["Vanilla", "110", Colors.brown, "assets/images/donut-1.png"],
    ["KitKat", "140", Colors.pink, "assets/images/donut-4.png"],
    ["Oreo", "50", Colors.blue, "assets/images/donut-2.png"],
    ["Cookies", "50", Colors.orange, "assets/images/donut-2.png"],
    
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




