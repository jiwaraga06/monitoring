import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  final Color? color;
  const CustomButton({super.key, this.text, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.amber,
      child: SizedBox(
        height: 40,
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
              child: Text(
            text!,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )),
        ),
      ),
    );
  }
}
