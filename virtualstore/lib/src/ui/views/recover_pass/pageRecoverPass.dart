import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:virtualstore/src/controllers/user.dart';
import 'package:scoped_model/scoped_model.dart';

class PageRecoverPass extends StatefulWidget {
  const PageRecoverPass({super.key});

  @override
  State<PageRecoverPass> createState() => _PageRecoverPassState();
}

class _PageRecoverPassState extends State<PageRecoverPass> {
  TextEditingController _controller = TextEditingController();
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: [
          _buildBodyBack(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Recuperação de Conta",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(2)),
                const Text(
                  "Por favor, insira seu endereço de e-mail abaixo. Enviaremos instruções para recuperar sua conta.",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                const Text(
                  "E-mail:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 4),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'exemplo@gmail.com',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black54,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    onChanged: on_changed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.all(12),
        width: double.maxFinite,
        child: ScopedModelDescendant<Users>(
          builder: (context, child, model) => ElevatedButton(
            onPressed: !active
                ? null
                : () {
                    model.recoverPass(
                      email: _controller.text,
                      onFail: onFail,
                      onSucess: onSucess,
                    );
                  },
            child: Text(
              'Enviar',
              style: TextStyle(color: active ? Colors.white : Colors.white38),
            ),
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
              backgroundColor: MaterialStatePropertyAll(active
                  ? Theme.of(context).primaryColor
                  : Color.fromARGB(197, 4, 125, 141)),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBodyBack() {
    return Container(
      color: Color.fromARGB(11, 0, 0, 0),
    );
  }

  on_changed(String value) {
    if (value.isNotEmpty && value.contains('@')) {
      if (!active) {
        setState(() {
          active = true;
        });
      }
    } else {
      if (active) {
        setState(() {
          active = false;
        });
      }
    }
  }

  onSucess() async {
    _controller.text = '';
    setState(() {
      FocusScope.of(context).unfocus();

      active = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Por favor, verifique a caixa de mensagem do E-mail!"),
        duration: Duration(seconds: 2),
      ),
    );

    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }

  onFail() {
    _controller.text = '';
    setState(() {
      FocusScope.of(context).unfocus();

      active = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("E-mail inválido!"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
