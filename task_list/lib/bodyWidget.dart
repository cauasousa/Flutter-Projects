import 'package:flutter/material.dart';
import 'package:task_list/addtask.dart';
import 'package:task_list/listtask.dart';
import 'package:task_list/requestionJson.dart';

class BodyWidget extends StatefulWidget {
  BodyWidget({super.key, required this.datas});
  final List? datas;
  @override
  State<BodyWidget> createState() => _BodyWidgetState(datas: datas);
}

class _BodyWidgetState extends State<BodyWidget> {
  _BodyWidgetState({required this.datas}){
    _data = datas == null ? [] : datas!;
  }

  List? datas;
  late List _data;
  int indexRemove = -1;
  var elementRemove;

  TextEditingController addTask = TextEditingController();

  String? msgError = null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AddItem(add: add, msgError: msgError, addTask: addTask),
          ListTask(data: _data, change: change, delete: delete),
        ],
      ),
    );
  }

  void add() {
    if (addTask.text != "") {
      setState(() {
        _data.insert(0, {"task": addTask.text, "status": false});
        addTask.text = '';
        msgError = null;
      });

      savedata(_data);
    } else {
      setState(() {
        msgError = "Write Task. Ex.: Read a book";
      });
    }
  }

  void delete(index) {
    

    indexRemove = index;
    elementRemove = _data.elementAt(indexRemove);

    setState(() {
      _data.removeAt(index);
    });

    savedata(_data);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Row(
          children: [
            Expanded(child: Text("It has been successfully removed!")),
            Align(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _data.insert(indexRemove, elementRemove);
                  });
                },
                child: Text(
                  "Unmake",
                  
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _refresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _data.sort(
        (a, b) {
          if (a["status"] && !b["status"])
            return 1;
          else if (!a["status"] && b["status"]) return -1;
          return 0;
        },
      );
    });

    savedata(_data);
  }

  void change(int index) async {
    setState(() {
      _data[index]["status"] = !_data[index]["status"];
    });

    _refresh();
  }
}
