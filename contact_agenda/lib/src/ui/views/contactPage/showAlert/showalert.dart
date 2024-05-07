import 'package:flutter/material.dart';

void showAlert(BuildContext  context){
  showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Discard Changes ?'),
                content: const Text('If you exit, the changes will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            }
            );
}