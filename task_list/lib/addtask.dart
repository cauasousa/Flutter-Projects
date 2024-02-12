import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  AddItem({
    super.key,
    required this.add,
    required this.addTask,
    required this.msgError,
  });

  final Function() add;
  final String? msgError;
  final TextEditingController addTask;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TextField(
            controller: widget.addTask,
            decoration: InputDecoration(
              label: Text("New Task"),
              labelStyle: TextStyle(color: Colors.blue),
              border: UnderlineInputBorder(),
              errorText: widget.msgError,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
        SizedBox(
          child: ElevatedButton(
            onPressed: () {
              widget.add();
            },
            child: Text(
              "ADD",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blue),
              shape: MaterialStatePropertyAll(
                LinearBorder.start(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}