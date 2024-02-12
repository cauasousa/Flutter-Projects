import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  AddItem(
      {super.key,
      required this.textvalue,
      required this.additem,
      required this.alterarShow});

  final TextEditingController textvalue;
  final Function() additem;
  final Function(bool) alterarShow;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String? textError = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          // flex: 100,

          child: SizedBox(
            height: 50,
            child: TextField(
              controller: widget.textvalue,
              decoration: InputDecoration(
                labelText: 'Adicione uma Tarefa',
                hintText: 'Ex.: Estudar',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 14,
                ),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: const Color.fromARGB(255, 112, 210, 248),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 6.0)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            fixedSize: Size(50, 50),
            backgroundColor: const Color.fromARGB(255, 112, 210, 248),
            alignment: Alignment.center,
            padding: EdgeInsets.all(0),
          ),
          onPressed: () {
            if (widget.textvalue.text == '') {
              setState(() {
                widget.alterarShow(true);
              });
            } else {
              widget.alterarShow(false);
              widget.additem();
            }
          },
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
