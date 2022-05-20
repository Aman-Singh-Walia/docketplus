import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showToast(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Text(
      msg,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: CupertinoColors.activeBlue,
    duration: const Duration(seconds: 1),
    elevation: 0.0,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
