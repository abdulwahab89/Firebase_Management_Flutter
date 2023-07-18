import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({required this.title, required this.onPress, Key? key})
      : super(key: key);
  String? title;
  VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(25),
        ),
        width: 200,
        child: Center(
            child: Text(
          title.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
