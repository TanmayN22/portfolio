// page_indicator.dart
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  final ValueChanged<int> onPageSelected;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        bool isActive = currentPage == index;
        return GestureDetector(
          onTap: () => onPageSelected(index),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 30 : 16,
            height: 8,
            decoration: BoxDecoration(
              color: isActive ? Colors.blueAccent : Colors.grey.shade400,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
