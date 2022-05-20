import 'package:flutter/material.dart';

class NoItem extends StatelessWidget {
  final String msg;
  const NoItem({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        msg,
        style: const TextStyle(
            fontFamily: 'SF',
            fontWeight: FontWeight.bold,
            color: Colors.black12,
            fontSize: 20.0),
      ),
    );
  }
}
