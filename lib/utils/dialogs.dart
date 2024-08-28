import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

myDialog(
    {required BuildContext context,
    required String title,
    required String message}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"))
            ],
          ));
}
