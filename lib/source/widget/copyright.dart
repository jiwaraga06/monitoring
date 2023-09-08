import 'package:flutter/material.dart';

class MyCopyright extends StatelessWidget {
  const MyCopyright({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.copyright, color: Colors.white),
          Text(' IT DEPARTMENT | PT Sipatex Putri Lestari | ', style: TextStyle(color: Colors.white, fontSize: 15)),
          Text('V 1.0', style: TextStyle(color: Colors.white, fontSize: 15)),
        ],
      ),
    );
  }
}
