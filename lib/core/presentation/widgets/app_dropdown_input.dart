import 'package:flutter/material.dart';

class AppDropdownInput extends StatelessWidget {
  AppDropdownInput(
      { required this.controller,
        required this.items,
        required this.hintText,
        required this.onSelected,
        Key? key}) : super(key: key);

  TextEditingController controller;
  Function(String) onSelected;
  List<String> items;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
       readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: PopupMenuButton<String>(
          icon: const Icon(Icons.arrow_drop_down),
          onSelected:onSelected,
          itemBuilder: (BuildContext context) {
            return items
                .map<PopupMenuItem<String>>((String value) {
              return  PopupMenuItem(
                  value: value,
                  child:  Text(value));
            }).toList();
          },
        ),
      ),
    );
  }
}
