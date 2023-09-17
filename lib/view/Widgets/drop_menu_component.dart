import 'package:flutter/material.dart';

class DropdownMenuComponent extends StatelessWidget {
  final String hint;
  final List<String> items;
  final Function(String?) onchange;
  const DropdownMenuComponent(
      {Key? key,
      required this.items,
      required this.hint,
      required this.onchange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: null,
      hint: Text(hint),
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onChanged: onchange,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
