import 'package:flutter/material.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class SearchField extends StatelessWidget {
  SearchField({Key? key, this.controller, this.onChange, this.onEditingComplete}) : super(key: key);
  var controller;
  var onChange;
  var onEditingComplete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        controller: controller,
        onChanged: onChange,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            suffixIcon: Icon(
              Icons.search_outlined,
              color: AppColors.colorSecondary,
            ),
            hintText: "Search",
        labelStyle: TextStyle(color: AppColors.textColor)
        ),
      ),
    );
  }
}
