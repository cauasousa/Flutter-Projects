// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  TextComposer({super.key, required this.getTextMSG});

  Function(String, File?) getTextMSG;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _msgValueIsEmpty = true;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          IconButton(
            onPressed: pathPhoto,
            icon: const Icon(Icons.photo_camera),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(
                hintText: 'Enviar Mensagem',
              ),
              onChanged: (value) {
                setState(() {
                  _msgValueIsEmpty = value.toString().isEmpty;
                });
              },
              onSubmitted: (value) {
                _reset(value);
              },
            ),
          ),
          IconButton(
            onPressed: _msgValueIsEmpty
                ? null
                : () {
                    _reset(_controller.text);
                  },
            icon: const Icon(
              Icons.send,
            ),
          ),
        ],
      ),
    );
  }

  pathPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    
    if (photo != null) {
      widget.getTextMSG('', File(photo.path));

      _controller.text = '';
      setState(() {
        _msgValueIsEmpty = true;
      });
    }
  }

  void _reset(String text) {

    widget.getTextMSG(text, null);
    
    _controller.text = '';
    setState(() {
      _msgValueIsEmpty = true;
    });
  }
}
