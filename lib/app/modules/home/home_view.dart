import 'package:flutter/material.dart';
import 'package:porfolio/app/widgets/nav_bar.dart';
import 'package:porfolio/app/widgets/status_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatusBar(),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [],
          ),
        ),
        NavBar(),
        SizedBox(height: 5),
      ],
    );
  }
}
