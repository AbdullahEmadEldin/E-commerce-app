import 'package:flutter/material.dart';

class CategoryOption extends StatelessWidget {
  final String category;
  final bool isSelected;
  const CategoryOption({
    super.key,
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 4,
          color: isSelected ? Colors.red : Colors.white,
        ))),
        width: size.width * 0.32,
        child: Center(
          child: Text(
            category,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ));
  }
}
