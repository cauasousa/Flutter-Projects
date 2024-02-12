import 'package:flutter/material.dart';

class ListTask extends StatefulWidget {
  ListTask(
      {super.key,
      required this.data,
      required this.delete,
      required this.change});

  final List data;
  final Function(int) delete;
  final Function(int) change;

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              setState(() {
                widget.delete(index);
              });
            },
            background: Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment(-1, 0),
                child: Icon(
                  Icons.delete,
                ),
              ),
            ),
            child: CheckboxListTile(
              shape: BorderDirectional(bottom: BorderSide(width: 0.09)),
              contentPadding:
                  EdgeInsets.only(left: 4, bottom: 0, right: 0, top: 0),
              value: widget.data[index]["status"],
              title: Text(
                widget.data[index]["task"],
                style: TextStyle(fontSize: 16),
              ),
              onChanged: (value) {
                widget.change(index);
              },
              secondary: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 20,
                child: Icon(
                  widget.data[index]["status"] ? Icons.check : Icons.error,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
