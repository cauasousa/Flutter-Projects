import 'package:flutter/material.dart';

class WidgetTextField extends StatefulWidget {
  WidgetTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.stateOnChanged,
    this.textBool = true,
    this.emailbool = false,
  });

  final String text;
  final bool textBool, emailbool;
  final TextEditingController controller;
  final Function() stateOnChanged;

  @override
  State<WidgetTextField> createState() => _WidgetTextFieldState();
}

class _WidgetTextFieldState extends State<WidgetTextField> {
  bool tapVisibility = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: widget.controller,
      keyboardType: (widget.textBool
          ? (widget.emailbool ? TextInputType.emailAddress : TextInputType.text)
          : TextInputType.visiblePassword),

      validator: (value) {

        if(value != null && (value.isEmpty || (widget.emailbool && !value.contains('@')))){


          return "${widget.text} Invalid";


        }

        return null;
        
      },
      obscureText: !widget.textBool && tapVisibility,
      decoration: InputDecoration(
        hintText: widget.text,
        suffixIcon: widget.textBool
            ? null
            : IconButton(
                icon: Icon(
                  tapVisibility ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    tapVisibility = !tapVisibility;
                  });
                },
              ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        border: UnderlineInputBorder(),
      ),
      onChanged: (value) {
        print("ALTERAÇÂO");
        
        widget.stateOnChanged();
      },
    );
  }
}
