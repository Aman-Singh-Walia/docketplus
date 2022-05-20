import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showConfirmDialog(BuildContext context, String title, String message,
    String actmsg, Function action) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'SF',
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'SF'),
          ),
          actions: [
            const Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SF',
                          color: CupertinoColors.activeBlue),
                    )),
                TextButton(
                    onPressed: () {
                      action();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      actmsg,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SF',
                          color: CupertinoColors.activeBlue),
                    ))
              ],
            )
          ],
        ); //alert dialog
      });
}
