import 'package:flutter/material.dart';

class CommonDropdown extends StatelessWidget {
  const CommonDropdown(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.value,
      required this.hint});

  final List<String> items;
  final Function(String) onChanged;
  final String value;

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            hint: Align(
              alignment: Alignment.centerLeft,
              child: Text(hint),
            ),
            decoration: InputDecoration(
                border: border,
                enabledBorder: border,
                filled: false,
                hintText: hint,
                alignLabelWithHint: true),
            value: value,
            items: List.generate(
                items.length, (index) => menuItem(item: items[index])),
            onChanged: (value) {
              onChanged(value ?? "");
            },
          ),
        ),
      ],
    );
  }

  OutlineInputBorder get border =>
      const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54));

  DropdownMenuItem<String> menuItem({required String item}) => DropdownMenuItem(
        value: item,
        child: Text(item, style: const TextStyle(fontSize: 14)),
      );
}
